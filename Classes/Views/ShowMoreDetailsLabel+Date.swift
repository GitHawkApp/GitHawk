//
//  ShowMoreDetailsLabel+Date.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import DateAgo

extension ShowMoreDetailsLabel {

    func setText(date: Date, format: Date.AgoFormat = .long) {
        text = date.agoString(format)
        detailText = DateDetailsFormatter().string(from: date)
    }

}
