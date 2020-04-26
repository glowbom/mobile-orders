//
//  NetworkManager.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    static let YOUR_BACKEND_URL = "https://script.google.com/macros/s/AKfycbzpcDZYAP71FNvU8kHQG_KBd624DnYrcJfPvKJUCYpDyJEyejs/exec";
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: NetworkManager.YOUR_BACKEND_URL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.data
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume();
        }
    }
    
    func placeOrder(data: String) {
        if let url = URL(string: (NetworkManager.YOUR_BACKEND_URL + "?data=" + data)) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    //let receivedData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    //print(receivedData)
                }
            }
            task.resume();
        }
    }
}

