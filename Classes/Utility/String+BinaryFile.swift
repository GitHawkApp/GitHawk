//
//  String+BinaryFile.swift
//  Freetime
//
//  Created by Ivan Magda on 01/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

// MARK: String+BinaryFile

extension String {

    private static let supportedBinaries = [
        "pdf": "application/pdf"
    ]

    // MARK: Public API

    /// A Boolean value indicating whether a string has binary file suffix.
    ///
    /// Supported types: **pdf**.
    var hasBinarySuffix: Bool {
        return getBinarySuffix() != nil
    }

    /// Returns mime type for the supported binary files.
    var mimeType: String? {
        guard let type = getBinarySuffix() else { return nil }

        return String.supportedBinaries[type]!
    }

    // MARK: Private API

    private func getBinarySuffix() -> String? {
        for type in String.supportedBinaries.keys {
            if self.hasSuffix(type) {
                return type
            }
        }

        return nil
    }

}
