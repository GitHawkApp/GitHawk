//
//  RepositoryBranchUpdatable.swift
//  Freetime
//
//  Created by B_Litwin on 9/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol RepositoryBranchUpdatable: class {
    func updateBranch(to newBranch: String)
}
