//
//  ExpandableHeaderView.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func custonInit(poolName: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.textLabel?.text = poolName
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel?.textColor = UIColor.white
        
        if let poolName = self.textLabel?.text {
            switch poolName {
            case "ethermine.org":
                self.contentView.backgroundColor = Utils.hexStringToUIColor(hex: "#2c3e50")
            case "etc.ethermine.org":
                self.contentView.backgroundColor = Utils.hexStringToUIColor(hex: "#2ecc71")
            case "zcash.flypool.org":
                self.contentView.backgroundColor = Utils.hexStringToUIColor(hex: "#f39c12")
            default:
                self.contentView.backgroundColor = Utils.hexStringToUIColor(hex: "#2980b9")
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
