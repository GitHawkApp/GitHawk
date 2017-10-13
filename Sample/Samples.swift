//
//  Samples.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 6/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func runningInSample() -> Bool {
    return Bundle.main.object(forInfoDictionaryKey: "RUN_AS_SAMPLE") as? Bool ?? false
}

func sampleUserSession() -> GithubUserSession? {
    guard runningInSample() else { return nil }
    return GithubUserSession(token: "1234", authMethod: .oauth, username: "tester")
}

func loadSample(path: String) -> Any? {
    guard runningInSample() else { return nil }
    let url = Bundle.main.url(forResource: path, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    return try! JSONSerialization.jsonObject(with: data, options: [])
}

final class SampleURLCache: URLCache {

    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        let resource = request.url!.path.replacingOccurrences(of: "/", with: "_")
        if let fileURL = Bundle.main.url(forResource: resource, withExtension: "json") {
            print("Loading sample data: \(resource).json")
            let data = try! Data(contentsOf: fileURL)
            let response = URLResponse(url: request.url!, mimeType: "application/json", expectedContentLength: data.count, textEncodingName: "utf-8")
            return CachedURLResponse(response: response, data: data)
        } else {
            print("Missed cache: \(resource).json")
            return super.cachedResponse(for: request)
        }
    }

}
