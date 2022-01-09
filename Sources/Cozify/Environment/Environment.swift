//
//  Bundle+IsProduction.swift
//  
//
//  Created by Rinat Abidullin on 09.01.2022.
//

import Foundation

public struct Environment {
    public enum Configuration: String {
        case debug
        case simulator
        case testflight
        case production
    }
    
    public static let isDebug: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    public static let isSimulator: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }()
    
    public static var isTestFlight: Bool = {
        guard !Self.isSimulator else { return false }
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return false }
        return Self.isSandboxReceiptContained(in: path)
    }()
    
    public static var isProduction: Bool = {
        guard !Self.isSimulator, !Self.isTestFlight else { return false }
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return true }
        return !Self.isSandboxReceiptContained(in: path)
    }()
    
    public static let firstAppliedConfiguration: Configuration = {
        if Self.isDebug {
            return .debug
        } else if Self.isSimulator {
            return .simulator
        } else if Self.isTestFlight {
            return .testflight
        } else {
            return .production
        }
    }()
    
    public static let appliedConfigurations: [Configuration] = {
        var configurations: [Configuration] = []
        if Self.isDebug {
            configurations.append(.debug)
        } else if Self.isSimulator {
            configurations.append(.simulator)
        } else if Self.isTestFlight {
            configurations.append(.testflight)
        } else {
            configurations.append(.production)
        }
        return configurations
    }()
    
    public static let description: String = {
        var description = "First applied configuration = \(Self.firstAppliedConfiguration)\n"
        description += "Applied configurations = \(Self.appliedConfigurations)\n"
        description += "More detailed:\n"
        description += "isDebug = \(Self.isDebug)\n"
        description += "isSimulator = \(Self.isSimulator)\n"
        description += "isTestFlight = \(Self.isTestFlight)\n"
        description += "isProduction (App Store) = \(Self.isProduction)"
        return description
    }()
    
    private static func isSandboxReceiptContained(in path: String) -> Bool {
        return path.contains("sandboxReceipt")
    }
}
