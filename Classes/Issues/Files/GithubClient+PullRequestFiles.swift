//
//  GitHubClient+PullRequestFiles.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension GithubClient {

    func fetchFiles(
        owner: String,
        repo: String,
        number: Int,
        page: Int,
        completion: @escaping (Result<([File], Int?)>) -> Void
        ) {
        request(Request(
            client: userSession?.client,
            path: "repos/\(owner)/\(repo)/pulls/\(number)/files",
            parameters: [
                "per_page": 50,
                "page": page
            ],
            completion: { (response, nextPage) in
                if let arr = response.value as? [ [String: Any] ] {
                    var files = [File]()
                    for json in arr {
                        if let file = File(json: json) {
                            files.append(file)
                        }
                    }
                    completion(.success((files, nextPage?.next)))
                } else {
                    completion(.error(nil))
                }
        }))
    }

    func fetchContents(
        contentsURLString: String,
        completion: @escaping (Result<(NSAttributedStringSizing, Content)>) -> Void
        ) {
        request(Request(url: contentsURLString, completion: { (response, _) in
            if let json = response.value as? [String: Any] {
                DispatchQueue.global().async {
                    if let content = Content(json: json),
                        let data = Data(base64Encoded: content.content, options: [.ignoreUnknownCharacters]),
                        let text = String(data: data, encoding: .utf8) {
                        let attributes = [
                            NSAttributedStringKey.font: Styles.Fonts.code,
                            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
                        ]
                        let attributedText = NSAttributedString(string: text, attributes: attributes)
                        let sizing = NSAttributedStringSizing(
                            containerWidth: 0,
                            attributedText: attributedText,
                            inset: Styles.Sizes.textViewInset
                        )
                        DispatchQueue.main.async {
                            completion(.success((sizing, content)))
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.error(nil))
                        }
                    }
                }
            } else {
                completion(.error(nil))
            }
        }))
    }

}
