//
//  Build.swift
//  BitriseKit
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import Foundation

public struct Build: Decodable {
    public enum Status: Int, Codable {
        case notFinished = 0
        case success = 1
        case failure = 2
        case aborted = 3
    }
    
    public let abortReason: String?
    public let branch: String?
    public let buildNumber: Int
    public let commitHash: String?
    public let commitMessage: String?
    public let commitViewURL: URL?
    public let environmentPrepareFinishedAt: Date?
    public let finishedAt: Date?
    public let isOnHold: Bool
    public let pullRequestId: Int
    public let pullRequestTargetBranch: String?
    public let pullRequestViewURL: URL?
    public let slug: String
    public let stackConfigType: String
    public let stackIdentifier: String
    public let startedOnWorkerAt: Date
    public let status: Status
    public let statusText: String
    public let tag: String?
    public let triggeredAt: Date
    public let triggeredBy: String?
    public let triggeredWorkflow: String
    
    private enum CodingKeys: String, CodingKey {
        case abortReason = "abort_reason"
        case branch
        case buildNumber = "build_number"
        case commitHash = "commit_hash"
        case commitMessage = "commit_message"
        case commitViewURL = "commit_view_url"
        case environmentPrepareFinishedAt = "environment_prepare_finished_at"
        case finishedAt = "finished_at"
        case isOnHold = "is_on_hold"
        case pullRequestId = "pull_request_id"
        case pullRequestTargetBranch = "pull_request_target_branch"
        case pullRequestViewURL = "pull_request_view_url"
        case slug
        case stackConfigType = "stack_config_type"
        case stackIdentifier = "stack_identifier"
        case startedOnWorkerAt = "started_on_worker_at"
        case status
        case statusText = "status_text"
        case tag
        case triggeredAt = "triggered_at"
        case triggeredBy = "triggered_by"
        case triggeredWorkflow = "triggered_workflow"
    }
}
