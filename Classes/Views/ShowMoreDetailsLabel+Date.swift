//
//  ShowMoreDetailsLabel+Date.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ShowMoreDetailsLabel {

    func setText(date: Date) {
        text = date.agoString
        detailText = DateDetailsFormatter().string(from: date)
    }

}
