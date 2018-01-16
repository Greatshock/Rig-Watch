//
//  ApiService.swift
//  Miner Office
//
//  Created by Nikita Marinosyan on 08.01.2018.
//  Copyright © 2018 Nikita Marinosyan. All rights reserved.
//

import Foundation

enum ApiService {
    
    static func getWorkersByPoolAndAddress(pool: Pool, minerAddress: String,
                                           onError: @escaping (_ title: String, _ message: String) -> (),
                                           onCompletion: @escaping (_ address: String, _ workersJson: JSON) -> ()) {
        
        let url = URL(string: pool.endpoint + "/miner/" + minerAddress + "/workers/monitor")
        
        // Send GET request
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    // Parse JSON data
                    let jsonData = try JSON(data: data)
                    guard let data = jsonData.dictionary else { print("Error parsing data"); return }
                    // Check status
                    guard let status = data["status"]?.string else { print("Error parsing status"); return }
                    if status != "OK" { // Error
                        let err = data["error"]?.string
                        print("Error: ", err!)
                        onError("Error", err!)
                    } else { // Ok
                        guard let workersData = data["data"] else { print("Error parsing workers data"); return }
                        if workersData.array?.count == 0 {
                            onError("Error", "No workers found. Check selected pool!")
                        } else {
                            onCompletion(minerAddress, workersData)
                        }
                    }
                } catch {
                    print("Error! Now in catch block")
                }
            }
        }.resume()
    }
}
