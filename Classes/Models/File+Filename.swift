//
//  File+Filename.swift
//  Freetime
//
//  Created by Weyert de Boer on 13/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension File {

    /// Returns the potential programming language of the file, if unsure it will return `nil`
    var potentialLanguage: String? {
        guard let fileExtension = self.filename.lowercased().components(separatedBy: ".").last else { return nil }
        switch fileExtension {
        case "swift": return "swift"
        default:
            return nil
        }
    }

    /// Returns the actual file name
    public var actualFileName: String {
        return  self.filename.components(separatedBy: "/").last ?? ""
    }
}
