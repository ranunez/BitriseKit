//
//  RetrieveLogEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct RetrieveLogEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success(log: Log)
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init(app: App, build: Build) {
        let endpoint = RetrieveLogEndpoint.baseURL.appendingPathComponent("apps").appendingPathComponent(app.slug).appendingPathComponent("builds").appendingPathComponent(build.slug).appendingPathComponent("log")
        endpointRequest = URLRequest(url: endpoint, method: .get)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else if let normalizedData = data?.normalizedJSONData {
                do {
                    let log = try JSONDecoder.default.decode(Log.self, from: normalizedData)
                    callback(ResponseCallback.success(log: log))
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
