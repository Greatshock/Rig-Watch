//
//  Pools.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

class Pool {
    var name: String!
    var endpoint: String!
    var addresses: [String]!
    var workers: [Worker]!
    
    init(name: String, endpoint: String) {
        self.name = name
        self.endpoint = endpoint
        self.addresses = []
        self.workers = []
    }
    
    func updateWorkers(address: String, workers: JSON) {
        
        if !addressExists(address: address) {
            addresses.append(address)
        }
        
        // Add workers one by one
        guard let workersArr = workers.array else { print("Error parsing workers from JSON"); return }
        for worker in workersArr {
            guard let workerInfo = worker.dictionary else { return }
            let workerName = workerInfo["worker"]?.string
            
            // Check if worker already exists
            var workerExists = false
            var index = 0
            for w in self.workers {
                if w.name == workerName {
                    workerExists = true
                    break
                }
                
                index += 1
            }
            
            if workerExists { // Worker exists
                
                // Update worker info
                self.workers[index].validShares = workerInfo["validShares"]?.stringValue
                self.workers[index].currentHashrate = workerInfo["currentHashrate"]?.stringValue
                self.workers[index].lastSeen = workerInfo["lastSeen"]?.stringValue
                self.workers[index].staleShares = workerInfo["staleShares"]?.stringValue
                self.workers[index].invalidShares = workerInfo["invalidShares"]?.stringValue
                
                let currentTime = Utils.getCurrentTimestamp()
                if (currentTime - Int64(self.workers[index].lastSeen)!) > 900 {
                    self.workers[index].status = Worker.Status.inactive
                } else {
                    self.workers[index].status = Worker.Status.active
                }
                
            } else {
                
                // Create new worker
                var newWorker = Worker(name: workerName!, address: address)

                // Add info about worker
                newWorker.validShares = workerInfo["validShares"]?.stringValue
                newWorker.currentHashrate = workerInfo["currentHashrate"]?.stringValue
                newWorker.lastSeen = workerInfo["lastSeen"]?.stringValue
                newWorker.staleShares = workerInfo["staleShares"]?.stringValue
                newWorker.invalidShares = workerInfo["invalidShares"]?.stringValue

                let currentTime = Utils.getCurrentTimestamp()
                if (currentTime - Int64(newWorker.lastSeen)!) > 900 {
                    newWorker.status = Worker.Status.inactive
                } else {
                    newWorker.status = Worker.Status.active
                }

                self.workers.append(newWorker)
            }
        }
    }
    
    private func addressExists(address: String) -> Bool {
        if addresses.count == 0 {
            return false
        }
        
        if (addresses.filter{$0 == address}.count > 0) {
            return true
        }
        
        return false
    }

}

let pools: [Pool] = [
    Pool(name: "ethermine.org", endpoint: "https://api.ethermine.org"),
    Pool(name: "etc.ethermine.org", endpoint: "https://api-etc.ethermine.org"),
    Pool(name: "zcash.flypool.org", endpoint: "https://api-zcash.flypool.org"),
    Pool(name: "ethpool.org", endpoint: "https://api.ethpool.org")
]
