//
//  String+FirstLine.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {

    var firstLine: String {
        return components(separatedBy: .newlines).first ?? self
    }

}
