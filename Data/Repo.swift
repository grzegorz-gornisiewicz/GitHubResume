//
//  Repo.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 13/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import Foundation

struct Repo: Codable {
    var name: String?
    var language: String?
    var description: String?
    var html_url: String?
    var created_at: String?
    var updated_at: String?
    var fork: Bool?
    var size: Int?
    var stargazers_count: Int?
    var forks: Int?
}
