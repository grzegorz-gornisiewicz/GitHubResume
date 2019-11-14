//
//  User.swift
//  GitHubResume
//
//  Created by Grzegorz Górnisiewicz on 12/11/2019.
//  Copyright © 2019 Grzegorz Górnisiewicz. All rights reserved.
//

import Foundation

/*
 base info:
 https://developer.github.com/v3/users/#get-a-single-user
 */
struct User: Codable {
    var login: String?
    var node_id: String?
    var avatar_url: String?
    var gravatar_id: String?
    var url: String?
    var html_url: String?
    var followers_url: String?
    var following_url: String?
    var gists_url: String?
    var starred_url: String?
    var subscriptions_url: String?
    var organizations_url: String?
    var repos_url: String?
    var events_url: String?
    var received_events_url: String?
    var type: String?
    var site_admin: Bool?
    var name: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: Bool?
    var bio: String?
    var public_repos: Int?
    var public_gists: Int?
    var followers: Int?
    var following: Int?
    var created_at: String?
    var updated_at: String?
}
