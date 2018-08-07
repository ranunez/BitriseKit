//
//  RetrieveYMLEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct RetrieveYMLEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success(yml: String)
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init(app: App) {
        let endpoint = RetrieveYMLEndpoint.baseURL.appendingPathComponent("apps").appendingPathComponent(app.slug).appendingPathComponent("bitrise.yml")
        endpointRequest = URLRequest(url: endpoint, method: .get)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else if let data = data {
                guard let string = String(data: data, encoding: .utf8) else {
                    callback(ResponseCallback.failure(errorMessage: "YML could not be serialized"))
                    return
                }
                callback(ResponseCallback.success(yml: string))
            } else {
                callback(ResponseCallback.failure(errorMessage: "An unexpected error occurred"))
            }
        }).resume()
    }
}
