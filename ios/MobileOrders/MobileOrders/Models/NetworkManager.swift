//
//  NetworkManager.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        
        let YOUR_BACKEND_URL = "https://script.googleusercontent.com/macros/echo?user_content_key=2q1KZ_es6HCFNyVLzX2FwIUWfmKCBEqOI5qP1ObvicfJoga9yCxQPIoW3AzUPWDykj0yIxk0fW2vBwAKMstXvHM_XnYHtl2Lm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnNxkG2S6rj5CJoMZL8yroI1JgtrxVEY1Fi4y4lgR_YXNRjeUfq2j9K5ZuNN5taqIHtpytj_A4aoE&lib=MCrWMhYCA2FXUw8BXiMBEmEulueVC4bK2";
        
        
        if let url = URL(string: YOUR_BACKEND_URL) {
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
}

