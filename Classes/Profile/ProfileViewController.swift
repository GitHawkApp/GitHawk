//
//  File.swift
//  Freetime
//
//  Created by Sash Zats on 2/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
  let client: GithubClient
  
  init(client: GithubClient) {
    self.client = client
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    client.fetchProfile { (result) in
      print(result)
    }
  }
}
