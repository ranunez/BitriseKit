//
//  Artifact.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct Artifact {
    public struct Metadata: Decodable {
        public let artifactType: String
        public let fileSizeBytes: Int
        public let isPublicPageEnabled: Bool
        public let slug: String
        public let title: String
        
        private enum CodingKeys: String, CodingKey {
            case artifactType = "artifact_type"
            case fileSizeBytes = "file_size_bytes"
            case isPublicPageEnabled = "is_public_page_enabled"
            case slug
            case title
        }
    }
    
    public let artifactMetadata: Metadata
    
    public let expiringDownloadURL: URL
    public let publicInstallPageURL: URL?
}

extension Artifact: Decodable {
    private enum CodingKeys: String, CodingKey {
        case expiringDownloadURL = "expiring_download_url"
        case publicInstallPageURL = "public_install_page_url"
    }
    
    /// Creates a new instance by decoding from the given decoder.
    public init(from decoder: Decoder) throws {
        let unkeyedContainer = try decoder.singleValueContainer()
        artifactMetadata = try unkeyedContainer.decode(Metadata.self)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        expiringDownloadURL = try values.decode(URL.self, forKey: .expiringDownloadURL)
        
        if let publicInstallPageURLString = try values.decodeIfPresent(String.self, forKey: .publicInstallPageURL) {
            publicInstallPageURL = URL(string: publicInstallPageURLString)
        } else {
            publicInstallPageURL = nil
        }
    }
}
