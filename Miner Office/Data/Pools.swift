//
//  Pools.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

struct Pool {
    var name: String!
    var endpoint: String!
    var workers: [Worker]!
    
    init(name: String, endpoint: String, workers: [Worker]) {
        self.name = name
        self.endpoint = endpoint
        self.workers = workers
    }
}

let pools: [Pool] = [
    Pool(name: "ethermine.org", endpoint: "https://api.ethermine.org", workers: []),
    Pool(name: "etc.ethermine.org", endpoint: "https://api-etc.ethermine.org", workers: [Worker(name: "kek"), Worker(name: "kek")]),
    Pool(name: "zcash.flypool.org", endpoint: "https://api-zcash.flypool.org", workers: []),
    Pool(name: "ethpool.org", endpoint: "https://api.ethpool.org", workers: [])
]
