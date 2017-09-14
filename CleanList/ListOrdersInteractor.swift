//
//  ListOrdersInteractor.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import Foundation

// MARK: - Interactor
class ListOrdersInteractor {
    
    public var presenter: ListOrdersFormattingLogic?
    
    var orders: [[Order]] = []
    lazy var worker: ListOrdersWorker = {
        let w = ListOrdersWorker()
        return w
    }()
    init() {}
    
}

// Datasource implementation
extension ListOrdersInteractor: ListOrdersDataSource {
    
    var numberOfSections: Int {
        return orders.count
    }
    func numberOfItems(in section: Int) -> Int {
        return orders[section].count
    }
    func order(at indexPath: IndexPath) -> Order {
        return orders[indexPath.section][indexPath.item]
    }
    
}

// Business logic implementation
extension ListOrdersInteractor: ListOrdersBusinessLogic {
    
    /*
     No response model passed to the presenter as the UICollectionViewDelegate and DataSource will query the interactor for what it needs via the ListOrdersDataSource methods
     */
    func process(loadOrders request: ListOrders.LoadOrder.Request) {
        worker.fetch { [weak self] orders in
            self?.orders = orders
        }
    }
    
    /*
     Even though the interactor simply passes along the index path it just received, here is the opportunity to log an event with your analytics service or fire off any other network requests (via a worker object of course)!
     */
    func process(selectOrder request: ListOrders.SelectOrder.Request) {
        let resposne = ListOrders.SelectOrder.Response(indexPathForDetailView: request.indexPath)
        presenter?.format(selectOrder: resposne)
    }
    
    // Model update and response outputted
    func process(moveOrder request: ListOrders.MoveOrder.Request) {
        let orderToMove = orders[request.sourceIndexPath.section].remove(at: request.sourceIndexPath.item)
        orders[request.destinationIndexPath.section].insert(orderToMove, at: request.destinationIndexPath.item)
        let response = ListOrders.MoveOrder.Response(sourceIndexPath: request.sourceIndexPath, destinationIndexPath: request.destinationIndexPath)
        presenter?.format(moveOrder: response)
    }
    
}


// MARK: - Worker
class ListOrdersWorker: ListOrdersDataStore {
    init() {}
    func fetch(orders: @escaping ([[Order]]) -> Void) {
        let fetchedOrders = groupedOrdersFetchedFromAStore
        orders(fetchedOrders)
    }
}


