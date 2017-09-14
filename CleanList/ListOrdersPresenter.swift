//
//  ListOrdersPresenter.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import Foundation

class ListOrdersPresenter {
    public weak var viewController: ListOrdersDisplayLogic?
    init() {}
}

extension ListOrdersPresenter: ListOrdersFormattingLogic {
    
    func format(selectOrder response: ListOrders.SelectOrder.Response) {
        let viewData = ListOrders.SelectOrder.ViewData(indexPathForDetailView: response.indexPathForDetailView)
        viewController?.display(selectOrder: viewData)
    }
    
    func format(moveOrder response: ListOrders.MoveOrder.Response) {
        let viewData = ListOrders.MoveOrder.ViewData(
            sourceIndexPath: response.sourceIndexPath,
            destinationIndexPath: response.destinationIndexPath
        )
        viewController?.display(moveOrder: viewData)
    }
    
}
