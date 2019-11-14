//
//  SingleUserRequest.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 12/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import Foundation

class SingleUserRequest {
    private let apiURL = "https://api.github.com/users/"
    private var task: URLSessionDataTask?
    
    func get(_ accountname: String, completion: @escaping (User?, _ error: Error?) -> Void) {
        if let urlComponents = URLComponents(string: apiURL + accountname) {
            guard let url = urlComponents.url else { return }
            task?.cancel()
            task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: data)
                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            })                
            task?.resume()
        }
    }
}
