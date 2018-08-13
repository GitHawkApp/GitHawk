//
//  UserProfileOverviewViewController.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Apollo
import SnapKit

protocol SetsTabmanTitlesDelegate: class {
    func setTitles(userRepoCount: Int, starredReposCount: Int)
}

class UserProfileOverviewViewController: UIViewController {
    private let client: UserProfileClient
    weak var setTabmanTitlesDelegate: SetsTabmanTitlesDelegate?
    
    init(client: UserProfileClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        //placeholder
        let label = UILabel()
        view.addSubview(label)
        label.text = "WIP"
        label.font = UIFont.systemFont(ofSize: 64)
        label.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
        //fetch user info
        //TODO
        client.fetchUserProfileInfo() { [weak self] result in
            self?.handle(result: result)
        }
    }
    
    func handle(result: GithubClient.UserProfileResultType) {
        //ALL TODOS
        switch result {
        case .error(let error):
            //TODO
            break
            
        case .success(let userProfile):
            setTabmanTitlesDelegate?.setTitles(userRepoCount: userProfile.repositoriesCount,
                                                          starredReposCount: userProfile.starredReposCount)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
