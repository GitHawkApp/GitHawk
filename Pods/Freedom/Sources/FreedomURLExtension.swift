//
//  FreedomURLExtension.swift
//  Freedom
//
//  Created by Sabintsev, Arthur on 7/2/17.
//  Copyright © 2017 Arthur Ariel Sabintsev. All rights reserved.
//

import Foundation

extension URL {

    func withoutScheme() -> URL? {
        let components = NSURLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.scheme = nil

        guard let url = components?.url else { return nil }

        let urlString = url.absoluteString
        let index = urlString.index(urlString.startIndex, offsetBy: 2)
        let modifiedString = urlString.substring(from: index)

        return URL(string: modifiedString)
    }

    func conformToHypertextProtocol() -> Bool {
        guard let scheme = self.scheme,
            scheme == URLComponents.Schemes.http || scheme == URLComponents.Schemes.https else {
                return false
        }

        return true
    }
    
}
