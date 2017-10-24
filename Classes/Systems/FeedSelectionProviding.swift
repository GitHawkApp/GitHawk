//
//  SelectionProviding.swift
//  Freetime
//
//  Created by Shahpour Benkau on 23/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

/// Specifies that the provider contains a feed and whether or not it currently contains a selection
protocol FeedSelectionProviding {

    /// Returns true when a selection has been made, false otherwise
    var feedContainsSelection: Bool { get }

}
