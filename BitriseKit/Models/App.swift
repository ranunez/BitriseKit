//
//  App.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct App: Decodable {
    public struct Owner: Decodable {
        public let accountType: String
        public let name: String
        public let slug: String
        
        private enum CodingKeys: String, CodingKey {
            case accountType = "account_type"
            case name
            case slug
        }
    }
    
    public let isDisabled: Bool
    public let isPublic: Bool
    public let owner: Owner
    public let projectType: String
    public let provider: String
    public let repoOwner: String
    public let repoSlug: String
    public let repoURL: URL
    public let slug: String
    public let status: Int
    public let title: String
    
    private enum CodingKeys: String, CodingKey {
        case isDisabled = "is_disabled"
        case isPublic = "is_public"
        case owner
        case projectType = "project_type"
        case provider
        case repoOwner = "repo_owner"
        case repoSlug = "repo_slug"
        case repoURL = "repo_url"
        case slug
        case status
        case title
    }
}
