//
//  DictionaryString+NSAttributedStringKey.swift
//  MessageViewController
//
//  Created by Ryan Nystrom on 10/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    var attributed: [NSAttributedStringKey: Any] {
        var map = [NSAttributedStringKey: Any]()
        forEach { map[NSAttributedStringKey($0)] = $1 }
        return map
    }

}
