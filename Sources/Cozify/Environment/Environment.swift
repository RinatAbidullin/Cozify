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
        case unitOrUiTest
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
        return Self.isSandboxReceiptContained(in: path) && !Self.hasEmbeddedMobileProvision
    }()
    
    public static var isProduction: Bool = {
        guard !Self.isSimulator, !Self.isTestFlight else { return false }
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return true }
        return !(Self.isSandboxReceiptContained(in: path) || Self.hasEmbeddedMobileProvision)
    }()
    
    public static var isUnitOrUiTest: Bool = {
        if
            NSClassFromString("XCTest") != nil ||
            UserDefaults.standard.value(forKey: "XCTIDEConnectionTimeout") != nil
        {
            return true
        }
        return false
    }()
    
    public static let appliedConfigurations: [Configuration] = {
        var configurations: [Configuration] = []
        if Self.isDebug {
            configurations.append(.debug)
        }
        if Self.isSimulator {
            configurations.append(.simulator)
        }
        if Self.isTestFlight {
            configurations.append(.testflight)
        }
        if Self.isProduction {
            configurations.append(.production)
        }
        if Self.isUnitOrUiTest {
            configurations.append(.unitOrUiTest)
        }
        return configurations
    }()
    
    public static let description: String = {
        let appliedConfigurations = Self.appliedConfigurations.map{ $0.rawValue }
        
        let isSandboxReceiptContained: Bool?
        if let path = Bundle.main.appStoreReceiptURL?.path {
            isSandboxReceiptContained = Self.isSandboxReceiptContained(in: path)
        } else {
            isSandboxReceiptContained = nil
        }
        
        var description = "Applied configurations = \(appliedConfigurations)\n"
        description += "More detailed:\n"
        description += "    isDebug = \(Self.isDebug)\n"
        description += "    isUnitOrUiTest = \(Self.isUnitOrUiTest)\n"
        description += "    isSimulator = \(Self.isSimulator)\n"
        description += "    isTestFlight = \(Self.isTestFlight)\n"
        description += "    isProduction (App Store) = \(Self.isProduction)\n"
        description += "Private:\n"
        description += "    isSandboxReceiptContained = \(isSandboxReceiptContained?.description ?? "missing path")\n"
        description += "    hasEmbeddedMobileProvision = \(Self.hasEmbeddedMobileProvision)"
        
        return description
    }()
    
    // MARK: - Private
    
    private static func isSandboxReceiptContained(in path: String) -> Bool {
        return path.contains("sandboxReceipt")
    }
    
    private static let hasEmbeddedMobileProvision: Bool = {
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return true
        }
        return false
    }()
}
