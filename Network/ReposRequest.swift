//
//  ReposRequest.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 13/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import Foundation

class ReposRequest {
    private let apiURL = "https://api.github.com/users/"
    private var task: URLSessionDataTask?

    func get(_ accountname: String, _ page: Int, completion: @escaping ([Repo]?, _ error: Error?) -> Void) {
        if let urlComponents = URLComponents(string: apiURL + accountname + "/repos?page=\(page + 1)") {
            guard let url = urlComponents.url else { return }
            task?.cancel()
            task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let repos = try decoder.decode([Repo].self, from: data)
                    completion(repos, nil)
                } catch {
                    completion(nil, error)
                }
            })
            task?.resume()
        }
    }
}
