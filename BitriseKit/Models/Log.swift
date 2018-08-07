//
//  Log.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct Log: Decodable {
    public struct Chunk: Decodable {
        let chunk: String
        let position: Int
    }
    
    public let expiringRawLogURL: URL
    public let totalGeneratedLogChunks: Int
    public let chunks: [Chunk]
    public let isArchived: Bool
    public let timestamp: Date?
    
    private enum CodingKeys: String, CodingKey {
        case expiringRawLogURL = "expiring_raw_log_url"
        case totalGeneratedLogChunks = "generated_log_chunks_num"
        case chunks = "log_chunks"
        case isArchived = "is_archived"
        case timestamp
    }
}
