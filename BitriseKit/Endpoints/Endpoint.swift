//
//  Endpoint.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/5/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

internal protocol APIEndpoint { }

extension APIEndpoint {
    static var baseURL: URL {
        return URL(string: "https://api.bitrise.io/v0.1/")!
    }
}

extension DecodingError {
    /// Human readble error message
    var debugMessage: String {
        switch self {
        case .dataCorrupted(let context):
            return "JSON Decode Data Corrupted Error: \(context)"
        case .keyNotFound(let context):
            return "JSON Decode Key Not Found Error: \(context)"
        case .typeMismatch(_, let context):
            return "JSON Decode Type Mismatch Error: \(context)"
        case .valueNotFound(_, let context):
            return "JSON Decode Value Not Found Error: \(context)"
        }
    }
}


extension URLRequest {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    /// Creates a new POST URLRequest instance containing JSON parameters
    init(url: URL, method: Method, parameters: [String: Any]? = nil) {
        self.init(url: url)
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        addValue("application/json", forHTTPHeaderField: "Accept")
        httpMethod = method.rawValue
        allHTTPHeaderFields = ["Authorization": Account.authorizationToken]
        
        if let parameters = parameters, let postData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            httpBody = postData
        }
    }
}

extension JSONDecoder {
    static var `default`: JSONDecoder {
        let decoder = JSONDecoder()
        
        if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        
        return decoder
    }
}

extension Data {
    var normalizedJSONData: Data? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: .allowFragments) else { return nil }
        
        let json: Any
        if let jsonDictionary = jsonObject as? [String: Any] {
            if let jsonData = jsonDictionary["data"] {
                json = jsonData
            } else {
                json = jsonDictionary
            }
        } else {
            json = jsonObject
        }
        
        return try? JSONSerialization.data(withJSONObject: json)
    }
}
