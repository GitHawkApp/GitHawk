//
//  ProjectViewController.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class ProjectViewController: UIViewController {
    
    private let client: GithubClient
    private let repository: RepositoryDetails
    private let project: Project
    
    // MARK: - Initialiser
    
    init(client: GithubClient, repository: RepositoryDetails, project: Project) {
        self.client = client
        self.repository = repository
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = project.name
    }
    
}
