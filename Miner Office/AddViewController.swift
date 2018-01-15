//
//  AddViewController.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var selectedPool = pools[0]
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addressTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        guard let address = addressTextField.text else { return }
        
        // Check if address is empty
        if address == "" {
            popupAlert(title: "Error", message: "Address text field is empty!")
            return
        }
        
        // Check address for invalid characters
        if Utils.addressContainsInvalidCharacters(addressToCheck: address) {
            popupAlert(title: "Error", message: "Address contains invalid characters!")
            return
        }
        
        // Get info about workers via API and add it to the workers model
        ApiService.getWorkersByPoolAndAddress(pool: selectedPool, minerAddress: address, onError: popupAlert) {addr, workersJson in
            DispatchQueue.main.async {
                self.activityIndicator.center = self.view.center
                self.activityIndicator.hidesWhenStopped = true
                self.view.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                self.selectedPool.updateWorkers(address: addr, workers: workersJson)
                self.tableView?.reloadData()
                self.navigationController?.popViewController(animated: true)
                
                sections[self.pickerView.selectedRow(inComponent: 0)].expanded = true
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                print(self.selectedPool.addresses)
            }
        }
    }
    
    func popupAlert(title: String, message: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Keyboard hiding by touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Keyboard hiding by pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pools[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPool = pools[row]
    }

}
