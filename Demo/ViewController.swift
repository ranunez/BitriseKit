//
//  ViewController.swift
//  Demo
//
//  Created by Ricardo Nunez on 8/6/18.
//  Copyright © 2018 Ricardo Nunez. All rights reserved.
//

import UIKit
import BitriseKit

internal final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveApps()
    }
    
    private func abortBuild(app: App, buildReceipt: BuildReceipt) {
        AbortBuildEndpoint(app: app, buildReceipt: buildReceipt)?.execute { (callback) in
            switch callback {
            case .success:
                if let buildNumber = buildReceipt.buildNumber {
                    print("Build #\(buildNumber) aborted!")
                }
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func createNewBuild(app: App, buildRequest: BuildRequest) {
        RunBuildEndpoint(app: app, buildRequest: buildRequest).execute { (callback) in
            switch callback {
            case .success(let buildReceipt):
                print(buildReceipt)
                self.abortBuild(app: app, buildReceipt: buildReceipt)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveArtifact(app: App, build: Build, artifactMetadata: Artifact.Metadata) {
        RetrieveArtifactEndpoint(app: app, build: build, artifactMetadata: artifactMetadata).execute { (callback) in
            switch callback {
            case .success(let artifact):
                print(artifact)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveArtifactsMetadata(app: App, build: Build) {
        RetrieveArtifactsMetadataEndpoint(app: app, build: build).execute { (callback) in
            switch callback {
            case .success(let metadata):
                print(metadata)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveLog(app: App, build: Build) {
        RetrieveLogEndpoint(app: app, build: build).execute { (callback) in
            switch callback {
            case .success(let logs):
                print(logs)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveBuilds(app: App) {
        RetrieveBuildsEndpoint(app: app).execute { (callback) in
            switch callback {
            case .success(let builds):
                print(builds)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveYML(app: App) {
        RetrieveYMLEndpoint(app: app).execute { (callback) in
            switch callback {
            case .success(let yml):
                print(yml)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveApps() {
        RetrieveAppsEndpoint().execute { (callback) in
            switch callback {
            case .success(let apps):
                print(apps)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveOrganization() {
        RetrieveOrganizationEndpoint().execute { (callback) in
            switch callback {
            case .success(let organizations):
                print(organizations)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
    
    private func retrieveAccount() {
        RetrieveAccountEndpoint().execute { (callback) in
            switch callback {
            case .success(let account):
                print(account)
            case .failure(let errorMessage):
                print("Error: \(errorMessage)")
            }
        }
    }
}

