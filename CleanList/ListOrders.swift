//
//  ListOrders.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import Foundation

// MARK: - Boundary objects
struct ListOrders {
    struct LoadOrder {
        struct Request {}
    }
    struct SelectOrder {
        struct Request {
            let indexPath: IndexPath
        }
        struct Response {
            let indexPathForDetailView: IndexPath
        }
        struct ViewData {
            let indexPathForDetailView: IndexPath
        }
    }
    struct MoveOrder {
        struct Request {
            let sourceIndexPath: IndexPath
            let destinationIndexPath: IndexPath
        }
        struct Response {
            let sourceIndexPath: IndexPath
            let destinationIndexPath: IndexPath
        }
        struct ViewData {
            let sourceIndexPath: IndexPath
            let destinationIndexPath: IndexPath
        }
    }
}


// MARK: - Boudnary interfaces
// Datasource
protocol ListOrdersDataSource {
    var numberOfSections: Int { get }
    func numberOfItems(in section: Int) -> Int
    func order(at indexPath: IndexPath) -> Order
}

// Business logic
protocol ListOrdersBusinessLogic {
    func process(loadOrders request: ListOrders.LoadOrder.Request)
    func process(selectOrder request: ListOrders.SelectOrder.Request)
    func process(moveOrder request: ListOrders.MoveOrder.Request)
}
// Data retrieval
protocol ListOrdersDataStore {
    func fetch(orders: @escaping ([[Order]]) -> Void)
}

// Presentation logic
protocol ListOrdersFormattingLogic {
    func format(selectOrder response: ListOrders.SelectOrder.Response)
    func format(moveOrder response: ListOrders.MoveOrder.Response)
}

// Display logic
protocol ListOrdersDisplayLogic: class {
    func display(selectOrder viewData: ListOrders.SelectOrder.ViewData)
    func display(moveOrder viewData: ListOrders.MoveOrder.ViewData)
}




