//
//  Parser.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Apollo

public protocol Request {
    associatedtype ResponseType: Response
}
