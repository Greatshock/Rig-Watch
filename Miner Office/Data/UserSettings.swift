//
//  UserSettings.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

enum UserSettings {
    
    static private func saveSectionsSettings() {
        UserDefaults.standard.set(sections[0].expanded, forKey: "ethermine.orgSectionIsExpanded")
        UserDefaults.standard.set(sections[1].expanded, forKey: "etc.ethermine.orgSectionIsExpanded")
        UserDefaults.standard.set(sections[2].expanded, forKey: "zcash.flypool.orgSectionIsExpanded")
        UserDefaults.standard.set(sections[3].expanded, forKey: "ethpool.orgSectionIsExpanded")
    }

    static private func fetchSectionsSettings() {
        if let expanded = UserDefaults.standard.object(forKey: "ethermine.orgSectionIsExpanded") {
            sections[0].expanded = expanded as! Bool
        } else {
            sections[0].expanded = false
        }
        if let expanded = UserDefaults.standard.object(forKey: "etc.ethermine.orgSectionIsExpanded") {
            sections[1].expanded = expanded as! Bool
        } else {
            sections[1].expanded = false
        }
        if let expanded = UserDefaults.standard.object(forKey: "zcash.flypool.orgSectionIsExpanded") {
            sections[2].expanded = expanded as! Bool
        } else {
            sections[2].expanded = false
        }
        if let expanded = UserDefaults.standard.object(forKey: "ethpool.orgSectionIsExpanded") {
            sections[3].expanded = expanded as! Bool
        } else {
            sections[3].expanded = false
        }
    }
    
    static func saveUserSettings() {
        saveSectionsSettings()
    }
    
    static func fetchUserSettings() {
        fetchSectionsSettings()
    }

}
