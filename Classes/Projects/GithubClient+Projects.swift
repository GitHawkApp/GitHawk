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

            DispatchQueue.global().async {
                var projects: [Project] = nodes.flatMap({ project in
                    guard let project = project else { return nil }
                    return Project(number: project.number, name: project.name, body: project.body, containerWidth: containerWidth, repo: repository)
                })
                
                if let last = projects.last {
                    // Using Alamofire for testing, so just duping the last one without a body to test both situations
                    projects.append(Project(number: last.number + 1, name: "Test Project w/o description", body: nil, containerWidth: containerWidth, repo: repository))
                }
                
                // Also need to return any paging info needed
                
                DispatchQueue.main.async {
                    completion(.success(projects))
                }
            }
        }
    }
    
    func load(project: Project, completion: @escaping (Result<Project.Details>) -> Void) {
        let query = ProjectQuery(owner: project.repository.owner, repo: project.repository.name, number: project.number)
        
        fetch(query: query) { (result, error) in
            guard error == nil, result?.errors == nil, let project = result?.data?.repository?.project else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error(nil))
                return
            }
            
            DispatchQueue.global().async {
                let columns: [Project.Details.Column]? = project.columns.nodes?.flatMap({
                    guard let column = $0 else { return nil }
                    // Need to parse cards
                    return Project.Details.Column(name: column.name, cards: [])
                })
                
                DispatchQueue.main.async {
                    completion(.success(Project.Details(columns: columns ?? [])))
                }
            }
        }
    }
    
}
