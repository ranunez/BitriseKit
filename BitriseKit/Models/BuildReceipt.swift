//
//  BuildReceipt.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct BuildReceipt: Decodable {
    public let buildNumber: Int?
    public let buildSlug: String?
    public let buildURL: URL?
    public let message: String
    public let service: String
    public let slug: String
    public let status: String
    public let triggeredWorkflow: String?
    
    private enum CodingKeys: String, CodingKey {
        case buildNumber = "build_number"
        case buildSlug = "build_slug"
        case buildURL = "build_url"
        case message
        case service
        case slug
        case status
        case triggeredWorkflow = "triggered_workflow"
    }
}
