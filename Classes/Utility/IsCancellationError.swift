//
//  IsCancellationError.swift
//  Freetime
//
//  Created by Hesham Salman on 10/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func isCancellationError(_ error: Error?) -> Bool {
    guard let error = error else { return false }
    return (error as NSError).code == -999
}
