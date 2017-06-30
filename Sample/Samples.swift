//
//  Samples.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func runningInSample() -> Bool {
    return true
}

func sampleUserSession() -> GithubUserSession? {
    guard runningInSample() else { return nil }
    let authJSON = loadSample(path: "authorizations") as! [String: Any]
    let auth = Authorization(json: authJSON)!
    return GithubUserSession(authorization: auth, login: "rnystrom")
}

func loadSample(path: String) -> Any? {
    guard runningInSample() else { return nil }
    let url = Bundle.main.url(forResource: path, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    return try! JSONSerialization.jsonObject(with: data, options: [])
}
