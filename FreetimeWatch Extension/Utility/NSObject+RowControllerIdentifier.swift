//
//  NSObject+RowControllerIdentifier.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension NSObject {

    static var rowControllerIdentifier: String {
        return String(describing: self)
    }

}
