//
//  ListOrdersViewCell.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import UIKit

class ListOrdersViewCell: UICollectionViewCell {
    
    typealias CellViewData = Order
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    public func set(with viewData: CellViewData) {
        self.titleLabel.text = viewData.title
        self.idLabel.text = "ID: \(viewData.id)"
    }
    
    override var reuseIdentifier: String? {
        return "OrderCell"
    }
}

