//
//  Bundle+IsProduction.swift
//  
//
//  Created by Rinat Abidullin on 09.01.2022.
//

import Foundation

public struct Environment {
    public static var isProduction: Bool {
        #if DEBUG
        return false
        #else
        guard let path = Bundle.main.appStoreReceiptURL?.path else {
            return true
        }
        return !(path.contains("CoreSimulator") || path.contains("sandboxReceipt"))
        #endif
    }
}
