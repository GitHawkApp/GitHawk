//
//  ShowErrorStatusBar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Squawk

func ShowErrorStatusBar(graphQLErrors: [Error]?, networkError: Error?) {
    if networkError != nil {
        Squawk.showNetworkError()
    } else if let graphQL = graphQLErrors?.first {
        Squawk.show(error: graphQL)
    }
}
