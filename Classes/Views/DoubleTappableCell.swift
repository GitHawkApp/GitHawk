//
//  GestureCell.swift
//  Freetime
//
//  Created by Joe Rocca on 10/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Foundation

protocol DoubleTappableCellDelegate: class {
    func didDoubleTap(cell: DoubleTappableCell)
}

class DoubleTappableCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    weak var doubleTapDelegate: DoubleTappableCellDelegate?

    let doubleTapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doubleTapGesture.addTarget(self, action: #selector(doubleTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.delegate = self
        addGestureRecognizer(doubleTapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private API
    
    @objc private func doubleTapAction() {
        doubleTapDelegate?.didDoubleTap(cell: self)
    }
    
    // MARK: UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
