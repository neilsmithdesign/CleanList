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
        lpgr.minimumPressDuration = 0.1
        return lpgr
    }()
    
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
            guard let indexPath = self.indexPathForItem(at: location) else { break }
            self.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            let location = gesture.location(in: self)
            self.updateInteractiveMovementTargetPosition(location)
        case .cancelled, .failed:
            self.cancelInteractiveMovement()
        case .ended:
            self.endInteractiveMovement()
        default:
            break
        }
    }
    
}

