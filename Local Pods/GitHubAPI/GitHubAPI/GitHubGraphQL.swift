//
//  GitHubGraphQL.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Apollo

public protocol GitHubGraphQLQueryRequest: Request {
    associatedtype QueryType: GraphQLQuery
    var query: QueryType { get }
}

public protocol GitHubGraphQLMutationRequest: Request {
    associatedtype MutationType: GraphQLMutation
    var mutation: MutationType { get }
}
