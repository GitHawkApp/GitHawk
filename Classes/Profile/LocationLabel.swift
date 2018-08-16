//
//  LocationLabel.swift
//  Freetime
//
//  Created by B_Litwin on 8/16/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class LocationLabel: UILabel {
    
    init(location: String) {
        super.init(frame: .zero)
        let textAttachment = NSTextAttachment()
        guard let image = UIImage(named: "location") else {
            fatalError("Couldn't get location image")
        }
        textAttachment.image = image
        textAttachment.bounds = CGRect(x: 0,
                                       y: (self.font.capHeight - image.size.height).rounded() / 2,
                                       width: image.size.width,
                                       height: image.size.height)
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(attachment: textAttachment))
        attributedText.append(NSAttributedString(string: " "))
        
        let attributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.body.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
        
        attributedText.append(NSAttributedString(string: location, attributes: attributes))
        self.attributedText = attributedText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





