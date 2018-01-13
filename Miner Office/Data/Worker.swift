//
//  Worker.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

struct Worker {
    var name: String!
    var status: Status!
    var address: String!
    var lastSeen: String!
    //var time: String!
    //var reportedHashrate: String
    var currentHashrate: String!
    var validShares: String!
    var invalidShares: String!
    var staleShares: String!
    //var averageHashrate: String
    
    enum Status: String {
        case active = "Active"
        case inactive = "Inactive"
        case pending = "Pending..."
    }
    
    init(name: String, address: String) {
        self.name = name
        self.status = Worker.Status.pending
        self.address = address
    }
}
