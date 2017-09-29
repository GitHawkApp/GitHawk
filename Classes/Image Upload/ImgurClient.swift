//
//  ImgurClient.swift
//  Freetime
//
//  Created by Sherlock, James on 29/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire

final class ImgurClient {
    
    static let hostpath = "https://api.imgur.com/3/"
    static let headers: HTTPHeaders = ["Authorization": "Client-ID \(ImgurAPI.clientID)"]
    
    func request(_ path: String,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil,
                 completion: @escaping (DataResponse<Any>) -> Void) {
        
        let encoding: ParameterEncoding
        switch method {
        case .get: encoding = URLEncoding.queryString
        default: encoding = JSONEncoding.default
        }
        
        Alamofire.request(ImgurClient.hostpath + path,
                          method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers ?? ImgurClient.headers).responseJSON(completionHandler: completion)
    }
    
    func canUploadImage(completion: @escaping (Bool) -> Void) {
        request("credits") { response in
            guard let dict = response.value as? [String: Any], let data = dict["data"] as? [String: Any] else {
                completion(false)
                return
            }
            
            guard let userRemaining = data["UserRemaining"] as? Int, let clientRemaining = data["ClientRemaining"] as? Int else {
                completion(false)
                return
            }
            
            // Takes 10 tokens to upload an image, a buffer has been added to prevent us using 100% of our allowance as this
            // will mean our app gets temporarily blocked from Imgur!
            completion(userRemaining > 20 && clientRemaining > 100)
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let data = UIImageJPEGRepresentation(image, 0.2) // Compression, lower is smaller files/worse quality.
            
            guard let base64 = data?.base64EncodedString() else {
                completion(.error(nil))
                return
            }
            
            let params = [
                "image": base64, // Base64 version of the provided image
                "type": "base64",
                "name": "GitHawk Upload" // Name, Title, Description? (All Optional)
            ]
            
            print("checkpoint alpha")
            self.request("image", method: .post, parameters: params) { response in
                print("checkpoint beta")
                guard let dict = response.value as? [String: Any], let data = dict["data"] as? [String: Any] else {
                    completion(.error(nil))
                    return
                }
                
                print(dict)
                
                guard let link = data["link"] as? String else {
                    completion(.error(nil))
                    return
                }
                
                completion(.success(link))
            }
        }
    }
    
}
