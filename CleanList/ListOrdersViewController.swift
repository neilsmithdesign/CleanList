//
//  ListOrdersViewController.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import UIKit

class ListOrdersViewController: UIViewController {
    
    fileprivate var datasource: ListOrdersDataSource!
    fileprivate var interactor: ListOrdersBusinessLogic!
    
    @IBOutlet weak var collectionView: UIReorderableCollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
    fileprivate var itemSize: CGSize {
        let width = collectionView.bounds.width - (sectionInsets.left + sectionInsets.right)
        return CGSize(width: width, height: 88.0)
    }
    fileprivate let lineSpacing: CGFloat = 4.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let viewController = self
        let interactor = ListOrdersInteractor()
        let presenter = ListOrdersPresenter()
        viewController.interactor = interactor
        viewController.datasource = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = ListOrders.LoadOrder.Request()
        interactor?.process(loadOrders: request)
    }
    
}

// MARK: - View controller calls to datasource
extension ListOrdersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource?.numberOfItems(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! ListOrdersViewCell
        let cellViewData = datasource.order(at: indexPath)
        cell.set(with: cellViewData)
        return cell
    }
}


// MARK: - View controller calls to business logic handler
extension ListOrdersViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let request = ListOrders.SelectOrder.Request(indexPath: indexPath)
        interactor.process(selectOrder: request)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let request = ListOrders.MoveOrder.Request(
            sourceIndexPath: sourceIndexPath,
            destinationIndexPath: destinationIndexPath
        )
        interactor.process(moveOrder: request)
    }
    
}



// MARK: - Input. Display logic
extension ListOrdersViewController: ListOrdersDisplayLogic {
    
    func display(selectOrder viewData: ListOrders.SelectOrder.ViewData) {
        // For managing segue, can call upon your 'router' here passing in the indexPath
    }
    
    func display(moveOrder viewData: ListOrders.MoveOrder.ViewData) {
        collectionView.reloadData()
        // Different collection view manipulations may require more specific moves/reloads
    }
    
}

extension ListOrdersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
}
