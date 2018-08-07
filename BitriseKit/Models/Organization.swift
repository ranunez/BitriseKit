//
//  Organization.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct Organization {
    public let name: String
    public let slug: String
    public let avatarURL: URL?
}

extension Organization: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case slug
        case avatarURL = "avatar_icon_url"
    }
    
    /// Creates a new instance by decoding from the given decoder.
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        slug = try values.decode(String.self, forKey: .slug)
        
        if let avatarURLString = try values.decodeIfPresent(String.self, forKey: .avatarURL) {
            avatarURL = URL(string: avatarURLString)
        } else {
            avatarURL = nil
        }
    }
}
