//
//  AppManager.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import Foundation

class AppManager: ObservableObject {

    @Published var orders = [Post]()
    
    var total: Float = 0.0;
    
    func addOrder(order: Post) {
        DispatchQueue.main.async {
            self.orders.append(order)
            self.total += order.price
        }
        
    }
}
