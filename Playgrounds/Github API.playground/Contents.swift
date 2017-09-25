//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func curl(request: NSURLRequest) {
    print(request)
    let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, err) in
        print(response)
        if let data = data {
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        } else {
            print(err ?? "error failure")
        }
    })
    task.resume()
}

let basic = "Basic " + "USERNAME:PASSWORD".data(using: .ascii)!.base64EncodedString()

let request = NSMutableURLRequest(url: URL(string: "https://api.github.com/authorizations")!)
request.httpMethod = "POST"
request.setValue(basic, forHTTPHeaderField: "Authorization")
request.setValue("123456", forHTTPHeaderField: "X-GitHub-OTP")
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")

let json: [String: Any] = [
    "scopes": ["repo"],
    "note": "gitter app development",
    "client_id": "CLIENT_ID",
    "client_secret": "CLIENT_SECRET",
]
request.httpBody = try! JSONSerialization.data(withJSONObject: json, options: [])

curl(request: request)
