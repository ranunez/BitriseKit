//
//  RetrieveArtifactsMetadataEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct RetrieveArtifactsMetadataEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success(artifactsMetadata: [Artifact.Metadata])
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init(app: App, build: Build) {
        let endpoint = RetrieveLogEndpoint.baseURL.appendingPathComponent("apps").appendingPathComponent(app.slug).appendingPathComponent("builds").appendingPathComponent(build.slug).appendingPathComponent("artifacts")
        endpointRequest = URLRequest(url: endpoint, method: .get)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else if let normalizedData = data?.normalizedJSONData {
                do {
                    let artifactsMetadata = try JSONDecoder.default.decode([Artifact.Metadata].self, from: normalizedData)
                    callback(ResponseCallback.success(artifactsMetadata: artifactsMetadata))
                } catch let error as DecodingError {
                    print(error.debugMessage)
                    callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
                } catch let error {
                    callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
                }
            } else {
                callback(ResponseCallback.failure(errorMessage: "An unexpected error occurred"))
            }
        }).resume()
    }
}
