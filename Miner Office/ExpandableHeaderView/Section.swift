//
//  Section.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

struct Section {
    var pool: Pool
    var expanded: Bool!
    
    init(pool: Pool, expanded: Bool) {
        self.pool = pool
        self.expanded = expanded
    }
}
