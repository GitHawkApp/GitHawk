//
//  ShowErrorStatusBar.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func ShowErrorStatusBar(graphQLErrors: [Error]?, networkError: Error?) {
    if networkError != nil {
        StatusBar.showNetworkError()
    }
    else if graphQLErrors != nil && graphQLErrors!.count > 0 {
        StatusBar.showGenericError()
    }
}
