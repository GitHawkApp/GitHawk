//
//  Processing.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

internal func processResponse<T: Request>(
    request: T,
    input: Any? = nil,
    response: HTTPURLResponse? = nil,
    error: Error? = nil
    ) -> Result<T.ResponseType> {
    guard let input = input as? T.ResponseType.InputType else {
        return .failure(ClientError.mismatchedInput)
    }
    guard error == nil else {
        return .failure(ClientError.network(error))
    }
    do {
        let output = try T.ResponseType(input: input, response: response)
        return .success(output)
    } catch {
        return .failure(ClientError.outputNil(error))
    }
}

internal func asyncProcessResponse<T: Request>(
    request: T,
    input: Any?,
    response: HTTPURLResponse?,
    error: Error?,
    completion: @escaping (Result<T.ResponseType>) -> Void
    ) {
    DispatchQueue.global().async {
        let result = processResponse(request: request, input: input, response: response, error: error)
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
