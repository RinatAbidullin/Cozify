//
//  Bundle+IsProduction.swift
//  
//
//  Created by Rinat Abidullin on 09.01.2022.
//

import Foundation

public struct Environment {
    public enum Configuration {
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
        guard !isDebug, !isSimulator else { return false }
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return false }
        return path.contains("sandboxReceipt")
    }()
    
    public static var isProduction: Bool = {
        guard !isDebug, !isSimulator, !isTestFlight else { return false }
        return true
    }()
    
    public static let configuration: Configuration = {
        if isDebug {
            return .debug
        } else if isSimulator {
            return .simulator
        } else if isTestFlight {
            return .testflight
        } else {
            return .production
        }
    }()
}
