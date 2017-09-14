//
//  Order.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import Foundation

// Model object
struct Order {
    var id: Int
    var title: String
}


// Fake database
let groupedOrdersFetchedFromAStore: [[Order]] = [
    [
        Order(id: 0, title: "A thing"),
        Order(id: 1, title: "Another thing"),
        Order(id: 2, title: "One more thing"),
        Order(id: 3, title: "Yet another thing"),
        Order(id: 4, title: "Final thing")
    ],
    [
        Order(id: 5, title: "Stuff"),
        Order(id: 6, title: "More stuff"),
        Order(id: 7, title: "Last bit of stuff")
    ],
    [
        Order(id: 8, title: "Single item")
    ]
    
]
