//
//  GithubClient+Projects.swift
//  Freetime
//
//  Created by Sherlock, James on 19/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {
    
    struct ProjectPayload {
        let projects: [Project]
        let nextPage: String?
    }
    
    func loadProjects(for repository: RepositoryDetails,
                      containerWidth: CGFloat,
                      nextPage: String?,
                      completion: @escaping (Result<ProjectPayload>) -> Void) {
        
        let query = LoadProjectsQuery(owner: repository.owner, repo: repository.name, after: nextPage)
        
        fetch(query: query) { (result, error) in
            guard error == nil, result?.errors == nil, let data = result?.data?.repository?.projects, let nodes = data.nodes else {
                ShowErrorStatusBar(graphQLErrors: result?.errors, networkError: error)
                completion(.error(nil))
                return
            }

            DispatchQueue.global().async {
                let projects: [Project] = nodes.flatMap({ project in
                    guard let project = project else { return nil }
                    
                    var body = project.body?.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Convert empty string into `nil`
                    if body?.isEmpty == true {
                        body = nil
                    }
                    
                    return Project(number: project.number,
                                   name: project.name,
                                   body: body,
                                   closed: project.state == .closed,
                                   containerWidth: containerWidth,
                                   repo: repository)
                })
                
                var nextPage: String?
                if data.pageInfo.hasNextPage {
                    nextPage = data.pageInfo.endCursor
                }
                
                DispatchQueue.main.async {
                    completion(.success(ProjectPayload(projects: projects, nextPage: nextPage)))
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
                    
                    let cards: [Project.Details.Column.Card]? = column.cards.nodes?.flatMap({
                        guard let card = $0 else { return nil }
                        
                        let issue = card.content?.asIssue
                        let pullRequest = card.content?.asPullRequest
                        
                        guard let title = issue?.title ?? pullRequest?.title ?? card.note else { return nil }
                        
                        var creator: Creator?
                        
                        if let login = card.creator?.login, let urlString = card.creator?.url, let url = URL(string: urlString) {
                            creator = Creator(login: login, url: url)
                        }
                        
                        var type: Project.Details.Column.Card.CardType
                        
                        if let issue = issue {
                            type = .issue(issue.closed ? .closed : .open, issue.number)
                        } else if let pullRequest = pullRequest {
                            var state: IssueStatus
                            
                            switch pullRequest.state {
                            case .closed: state = .closed
                            case .merged: state = .merged
                            case .open: state = .open
                            }
                            
                            type = .pullRequest(state, pullRequest.number)
                        } else {
                            type = .note
                        }
                        
                        return Project.Details.Column.Card(id: card.id, title: title, creator: creator, type: type)
                    })
                    
                    return Project.Details.Column(name: column.name, cards: cards ?? [], totalCount: column.cards.totalCount)
                })
                
                DispatchQueue.main.async {
                    completion(.success(Project.Details(columns: columns ?? [])))
                }
            }
        }
    }
    
}
