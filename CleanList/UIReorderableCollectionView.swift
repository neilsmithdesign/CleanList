//
//  UIReorderableCollectionView.swift
//  CleanList
//
//  Created by Neil Smith on 14/09/2017.
//  Copyright © 2017 NeilSmithDesignLTD. All rights reserved.
//

import UIKit

class UIReorderableCollectionView: UICollectionView {
    
    fileprivate lazy var longPressGestureRecognizer: UILongPressGestureRecognizer = {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handle(gesture:)))
        lpgr.minimumPressDuration = 0.3
        return lpgr
    }()
    fileprivate var indexPathForMovingCell: IndexPath = IndexPath(item: 0, section: 0)
    fileprivate var movingCell: UICollectionViewCell = UICollectionViewCell()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        assignGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assignGestureRecognizer()
    }
    
    private func assignGestureRecognizer() {
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handle(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            guard let indexPath = self.indexPathForItem(at: location) else { return }
            indexPathForMovingCell = indexPath
            guard let cell = self.cellForItem(at: indexPathForMovingCell) else { return }
            movingCell = cell
            movingCell.contentView.backgroundColor = UIColor.lightGray
            self.beginInteractiveMovementForItem(at: indexPathForMovingCell)
        case .changed:
            let location = gesture.location(in: self)
            self.updateInteractiveMovementTargetPosition(location)
        case .cancelled, .failed:
            movingCell.contentView.backgroundColor = UIColor.darkGray
            self.cancelInteractiveMovement()
        case .ended:
            movingCell.contentView.backgroundColor = UIColor.darkGray
            self.endInteractiveMovement()
        default:
            break
        }
    }
    
}

