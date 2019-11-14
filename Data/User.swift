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
    
//    private enum CodingKeys: String, CodingKey {
//        case pid = "id"
//        case login
//        case node_id
//        case avatar_url
//        case gravatar_id
//        case url
//        case html_url
//        case followers_url
//        case following_url
//        case gists_url
//        case starred_url
//        case subscriptions_url
//        case organizations_url
//        case repos_url
//        case events_url
//        case received_events_url
//        case type
//        case site_admin
//        case name
//        case blog
//        case location
//        case email
//        case hireable
//        case bio
//        case public_repos
//        case public_gists
//        case followers
//        case following
//        case created_at
//        case updated_at
//    }
}