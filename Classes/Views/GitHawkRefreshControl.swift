//
//  GitHawkRefreshControl.swift
//  PullToRefresh
//
//  Created by Ehud Adler on 8/6/18.
//  Copyright © 2018 Ehud Adler. All rights reserved.
//

import UIKit

class GitHawkRefreshControl: UIRefreshControl {
    
    override var frame: CGRect {
        get { return super.frame }
        set {
            var newFrame = newValue
            if let superScrollView = superview as? UIScrollView {
                update(y: superScrollView.contentOffset.y)
                newFrame.origin.x = superScrollView.frame.minX - superScrollView.contentInset.left
            }
            super.frame = newFrame
        }
    }
    
    public var progress: CGFloat = 0.0 {
        didSet {
            scale(percent: progress)
            setPlacement(percent: progress)
        }
    }
    private var startingHeight: CGFloat = 0
    
    private struct Insets {
        static let bird:CGFloat = 20
        static let refresh:CGFloat = 5
    }
    
    private var isPulsing = false
    
    private let birdImageView = UIImageView(image: #imageLiteral(resourceName: "splash"))
    private let contentView = UIView()
    
    // The tableview could start at a different Y offset.
    private var tableViewInitialYOffset: CGFloat?
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    required override init() {
        super.init()
        tintColor = .clear
        setUpView()
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        addBirdAnimation()
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        progress = 0
    }
    
    private func setUpView() {
        startingHeight = self.frame.height
        let imageHeight = startingHeight - Insets.refresh
        
        // ContentView
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        // Bird
        contentView.addSubview(birdImageView)
        birdImageView.translatesAutoresizingMaskIntoConstraints = false
        birdImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        birdImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        birdImageView.widthAnchor.constraint(equalToConstant: imageHeight - Insets.bird).isActive = true
        birdImageView.heightAnchor.constraint(equalToConstant: imageHeight - Insets.bird).isActive = true
    }
    
    private func update(y yOffset: CGFloat) {
        
        let adjOffset = -yOffset - startingHeight
        // Check if we have passed the point where the refresh control kicks in
        if !isPulsing && adjOffset > startingHeight {
            addBirdAnimation()
        }
        
        if adjOffset > 0 {
            self.updateProgress(adjOffset)
        }
    }
    
    private func updateProgress(_ yOffset: CGFloat) {
        // Convert to 0 - 1 scale
        progress = (yOffset * 100 / startingHeight) / 100
    }
    
    private func setPlacement(percent: CGFloat) {
        let adjPercent = percent < 1
            ? -startingHeight + (percent * startingHeight)
            : 1
        contentView.transform = CGAffineTransform(
            translationX: 1,
            y: adjPercent
        )
    }
    
    private func scale(percent: CGFloat) {
        let adjPercent = percent < 1
            ? percent
            : 1
        self.transform = CGAffineTransform(
            scaleX: adjPercent,
            y: adjPercent
        )
    }
    
    private func addBirdAnimation() {
        
        isPulsing = true
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 0.7
        pulseAnimation.duration = 1
        pulseAnimation.fillMode = kCAFillModeForwards
        pulseAnimation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionEaseInEaseOut
        )
        
        birdImageView.layer.add(
            pulseAnimation,
            forKey: "scaling"
        )
    }
}
