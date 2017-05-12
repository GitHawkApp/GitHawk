//
//  ViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var session: GithubSession!
    
    @IBAction func logout(_ sender: Any) {
        session.remove()
    }

}
