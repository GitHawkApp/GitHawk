//
//  NameAndLoginLabel.swift
//  Freetime
//
//  Created by B_Litwin on 8/16/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class NameAndLoginLabel: UILabel {
    
    init(login: String, name: String?) {
        super.init(frame: .zero)
        
        let leadingString: String
        let trailingString: String?
        if let name = name, !name.trimmingCharacters(in: .whitespaces).isEmpty {
            leadingString = name
            trailingString = login
        } else {
            leadingString = login
            trailingString = nil
        }
        
        let leadingAttributes: [NSAttributedStringKey: Any] = [
            .font: Styles.Text.bodyBold.preferredFont,
            .foregroundColor: Styles.Colors.Gray.dark.color
        ]
        
        let attributedText = NSMutableAttributedString(string: leadingString,
                                                       attributes: leadingAttributes
        )
        
        if let trailingString = trailingString {
            let trailingAttributes: [NSAttributedStringKey: Any] = [
                .font: Styles.Text.body.preferredFont,
                .foregroundColor: Styles.Colors.Gray.dark.color
            ]
            
            attributedText.append(NSAttributedString(string: "  "))
            attributedText.append(NSAttributedString(string: trailingString, attributes: trailingAttributes))
        }
        
        self.attributedText = attributedText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



