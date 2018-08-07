//
//  BuildRequest.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

/// Bitrise build request
public struct BuildRequest {
    /// Where build should be built off of
    public enum BuildMethod: String {
        /// Git branch
        case branch
        
        /// Git tag
        case tag
        
        /// Git commit hash
        case commitHash = "commit_hash"
    }
    
    /// Where build should be built off of
    public let buildMethod: BuildMethod
    
    /// Specific branch, tag, or commit hash to build off of
    public let buildMethodValue: String
    
    /// Name of the workflow to run
    public let workflowName: String
    
    /// Environment variables to pass to the build
    public let environmentVariables: [String: String]
    
    /// Creates a new build request
    public init(buildMethod: BuildMethod, buildMethodValue: String, workflowName: String, environmentVariables: [String: String] = [:]) {
        self.buildMethod = buildMethod
        self.buildMethodValue = buildMethodValue
        self.workflowName = workflowName
        self.environmentVariables = environmentVariables
    }
    
    /// JSON parameters containing the build information
    public var parameters: [String: Any] {
        let parameters: [String: Any] = [
            "hook_info": [
                "type": "bitrise"
            ],
            "build_params": [
                buildMethod.rawValue: buildMethodValue,
                "workflow_id": workflowName
            ],
            "triggered_by": "curl"
        ]
        
        if environmentVariables.isEmpty {
            return parameters
        } else {
            var updatedParameters = parameters
            updatedParameters["environments"] = environmentVariables.map({ [ "mapped_to": $0.key, "value": $0.value, "is_expand": true ] })
            return updatedParameters
        }
    }
}
