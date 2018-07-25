//
//  SplashView.swift
//  Freetime
//
//  Created by Yury Bogdanov on 25/07/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

final class SplashView: UIView {

    private var birdImageView: UIImageView!
    private var branchesImageView: UIImageView!
    
    convenience init() {
        self.init(frame: .zero)
        
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func setupView() {
        let imageView = UIImageView(image: UIImage(named: "splash"))
        imageView.image = UIImage(named: "splash")
        birdImageView = imageView
        addSubview(birdImageView)
        //        branchesImageView.image = nil // FIXME: After Photoshop installed
        
        birdImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func birdAnimations() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 0.9
        pulseAnimation.duration = 3
        pulseAnimation.fillMode = kCAFillModeForwards
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        birdImageView.layer.add(pulseAnimation, forKey: "scaling")
    }
    
    func beginAnimations() {
        birdAnimations()
    }

}
