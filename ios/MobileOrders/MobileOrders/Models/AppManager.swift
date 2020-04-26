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
    }

    var orders: [Post]
}
