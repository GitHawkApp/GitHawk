//
//  UserProfileViewController.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class UserProfileViewController:
    TabmanViewController,
    PageboyViewControllerDataSource,
    SetsTabmanTitlesDelegate
{
    private let controllers: [UIViewController]
    private let client: UserProfileClient
    private let userLogin: String
    
    init(gitHubClient: GithubClient,
         userLogin: String)
    {
        let userProfileClient = UserProfileClient(client: gitHubClient, userLogin: userLogin)
        self.client = userProfileClient
        self.userLogin = userLogin
        
        self.controllers = [
            UserProfileOverviewViewController(client: userProfileClient),
            UserProfileRepositoriesViewController(client: userProfileClient,
                                                  gitHubClient: gitHubClient,
                                                  tab: .userRepos),
            UserProfileRepositoriesViewController(client: userProfileClient,
                                                  gitHubClient: gitHubClient,
                                                  tab: .starredRepos)
        ]
        
        super.init(nibName: nil, bundle: nil)

        if let vc = controllers[0] as? UserProfileOverviewViewController {
            vc.setTabmanTitlesDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return controllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return controllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    // MARK: SetsTabmanTitlesDelegate
    
    func setTitles(userRepoCount: Int, starredReposCount: Int) {
        controllers[0].title = "Overview"
        controllers[1].title = "Repositories (\(userRepoCount))"
        controllers[2].title = "Starred (\(starredReposCount))"
        
        bar.items = controllers.map { Item(title: $0.title ?? "" )}
        
        bar.appearance = TabmanBar.Appearance({ appearance in
            appearance.text.font = Styles.Text.button.preferredFont
            appearance.state.color = Styles.Colors.Gray.light.color
            appearance.state.selectedColor = Styles.Colors.Blue.medium.color
            appearance.indicator.color = Styles.Colors.Blue.medium.color
        })
    }
}
