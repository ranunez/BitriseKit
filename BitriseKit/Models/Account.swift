//
//  Account.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/5/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct Account {
    public static var authorizationToken = "ADD_AUTHORIZATION_TOKEN_HERE"
    public let username: String
    public let slug: String
    public let avatarURL: URL?
}

extension Account: Decodable {
    private enum CodingKeys: String, CodingKey {
        case username
        case slug
        case avatarURL = "avatar_url"
    }
    
    /// Creates a new instance by decoding from the given decoder.
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decode(String.self, forKey: .username)
        slug = try values.decode(String.self, forKey: .slug)
        
        if let avatarURLString = try values.decodeIfPresent(String.self, forKey: .avatarURL) {
            avatarURL = URL(string: avatarURLString)
        } else {
            avatarURL = nil
        }
    }
}
