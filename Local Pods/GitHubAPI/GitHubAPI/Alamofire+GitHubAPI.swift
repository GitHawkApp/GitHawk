//
//  Alamofire+GitHubAPI.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.SessionManager: HTTPPerformer {

    public func send(
        url: String,
        method: HTTPMethod,
        parameters: [String : Any]?,
        headers: [String : String]?,
        completion: @escaping (HTTPURLResponse?, Any?, Error?) -> Void
        ) {

        let encoding: ParameterEncoding
        switch method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }

        let alamofireMethod: Alamofire.HTTPMethod
        switch method {
        case .delete: alamofireMethod = .delete
        case .get: alamofireMethod = .get
        case .post: alamofireMethod = .post
        case .put: alamofireMethod = .put
        case .patch: alamofireMethod = .patch
        }

        request(
            url,
            method: alamofireMethod,
            parameters: parameters,
            encoding: encoding,
            headers: headers
            ).responseData { response in
                completion(response.response, response.value, response.error)
        }
    }

}

