//
//  AppManager.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import Foundation

class AppManager {
    static let instance = AppManager()

    private init() {
        self.orders = []
        self.total = 0
    }

    var orders: [Post]
    var total: Float
    
    func addOrder(order: Post) {
        orders.append(order)
        total += order.price
    }
}
