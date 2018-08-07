//
//  AbortBuildEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct AbortBuildEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init?(app: App, buildReceipt: BuildReceipt) {
        guard let buildSlug = buildReceipt.buildSlug else { return nil }
        let endpoint = RetrieveLogEndpoint.baseURL.appendingPathComponent("apps").appendingPathComponent(app.slug).appendingPathComponent("builds").appendingPathComponent(buildSlug).appendingPathComponent("abort")
        endpointRequest = URLRequest(url: endpoint, method: .post)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else {
                callback(ResponseCallback.success)
            }
        }).resume()
    }
}
