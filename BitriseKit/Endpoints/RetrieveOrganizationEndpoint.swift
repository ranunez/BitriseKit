//
//  RetrieveOrganizationEndpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct RetrieveOrganizationEndpoint: APIEndpoint {
    /// Endpoint response callback
    public enum ResponseCallback {
        /// Success callback
        case success(organizations: [Organization])
        
        /// Failure JSON response callback
        case failure(errorMessage: String)
    }
    
    let endpointRequest: URLRequest
    
    public init() {
        let endpointURL = RetrieveOrganizationEndpoint.baseURL.appendingPathComponent("organizations")
        endpointRequest = URLRequest(url: endpointURL, method: .get)
    }
    
    public func execute(_ callback: @escaping (ResponseCallback) -> Void) {
        URLSession.shared.dataTask(with: endpointRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
            } else if let normalizedData = data?.normalizedJSONData {
                do {
                    let organizations = try JSONDecoder.default.decode([Organization].self, from: normalizedData)
                    callback(ResponseCallback.success(organizations: organizations))
                } catch let error as DecodingError {
                    callback(ResponseCallback.failure(errorMessage: error.debugMessage))
                } catch let error {
                    callback(ResponseCallback.failure(errorMessage: error.localizedDescription))
                }
            } else {
                callback(ResponseCallback.failure(errorMessage: "An unexpected error occurred"))
            }
        }).resume()
    }
}
