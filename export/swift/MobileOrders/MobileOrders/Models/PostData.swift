//
//  PostData.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let data: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String
    let product: String
    let desciption: String
    let price: Float
    let count: Int?
    let media: String?
    let choice1: String?
    let choice2: String?
    let choice3: String?
    let tips: Float?
    let tax: Float?
}

