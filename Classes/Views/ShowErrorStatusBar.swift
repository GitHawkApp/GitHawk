//
//  ShowErrorStatusBar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func ShowErrorStatusBar(graphQLErrors: [Error]?, networkError: Error?) {
    if networkError != nil {
        ToastManager.showNetworkError()
    }
    else if graphQLErrors != nil && graphQLErrors!.count > 0 {
        ToastManager.showGenericError()
    }
}
