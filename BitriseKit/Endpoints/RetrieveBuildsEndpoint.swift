//
//  RetrieveBuildsEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct RetrieveBuildsEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success(builds: [Build])
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init(app: App) {
        let endpoint = RetrieveBuildsEndpoint.baseURL.appendingPathComponent("apps").appendingPathComponent(app.slug).appendingPathComponent("builds")
        
        endpointRequest = URLRequest(url: endpoint, method: .get)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else if let normalizedData = data?.normalizedJSONData {
                do {
                    let builds = try JSONDecoder.default.decode([Build].self, from: normalizedData)
                    callback(ResponseCallback.success(builds: builds))
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
