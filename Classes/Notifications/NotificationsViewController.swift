//
//  NotificationsViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    let session: GithubSession

    init(session: GithubSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotifications(session: session) { result in
            switch result {
            case .noauth:
                print("no auth")
            case .success:
                print("success")
            case .failed:
                print("failed")
            }
        }
    }

}
