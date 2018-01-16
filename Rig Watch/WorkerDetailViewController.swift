//
//  WorkerDetailViewController.swift
//  Rig Watch
//
//  Created by Nikita Marinosyan on 16.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import UIKit

class WorkerDetailViewController: UIViewController {

    @IBOutlet weak var workerNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var lastSeenLabel: UILabel!
    @IBOutlet weak var currentHashrateLabel: UILabel!
    @IBOutlet weak var validSharesLabel: UILabel!
    @IBOutlet weak var staleSharesLabel: UILabel!
    @IBOutlet weak var invalidSharesLabel: UILabel!
    
    var worker: Worker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        workerNameLabel.text = worker?.name
        addressLabel.text = worker?.address
        
        let current = Utils.getCurrentTimestamp()
        let lastSeen = Int64((worker?.lastSeen)!)
        let minutesInterval = Int((Double(current - lastSeen!) / 60).rounded())
        if minutesInterval == 1 {
            lastSeenLabel.text = "\(minutesInterval) minute ago"
        } else {
            lastSeenLabel.text = "\(minutesInterval) minutes ago"
        }
        
        let currentHashrate = Double(worker!.currentHashrate)! / 1000000
        currentHashrateLabel.text = "\(String(format: "%.1f", currentHashrate)) MH/s"
        
        validSharesLabel.text = worker?.validShares
        staleSharesLabel.text = worker?.staleShares
        invalidSharesLabel.text = worker?.invalidShares
    }

}
