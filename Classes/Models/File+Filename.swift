//
//  File+Filename.swift
//  Freetime
//
//  Created by Weyert de Boer on 13/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension File {

    /// Returns the actual file name
    var actualFileName: String {
        return self.filename.components(separatedBy: "/").last ?? self.filename
    }
}
