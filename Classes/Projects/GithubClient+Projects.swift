//
//  GithubClient+Projects.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {
    
    func loadProjects(for repository: RepositoryDetails,
                      containerWidth: CGFloat,
                      nextPage: String?,
                      completion: @escaping (Result<[Project]>) -> Void) {
        
        let query = LoadProjectsQuery(owner: repository.owner, repo: repository.name, after: nextPage)
        
        fetch(query: query) { (result, error) in
            guard error == nil, result?.errors == nil, let nodes = result?.data?.repository?.projects.nodes else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error(nil))
                return
            }

            let projects: [Project] = nodes.flatMap({ project in
                guard let project = project else { return nil }
                return Project(number: project.number, name: project.name, body: project.body)
            })
            
            // TODO: Project needs to also calculate the height of the project name & body.
            
            completion(.success(projects))
        }
    }
    
    func load(project: Project, completion: @escaping (Result<Project.Details>) -> Void) {
        completion(.error(nil))
    }
    
}
