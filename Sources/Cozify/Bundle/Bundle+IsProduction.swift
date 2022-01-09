//
//  Bundle+IsProduction.swift
//  
//
//  Created by Rinat Abidullin on 09.01.2022.
//

import Foundation

extension Bundle {
    var isProduction: Bool {
        #if DEBUG
        return false
        #else
        guard let path = self.appStoreReceiptURL?.path else {
            return true
        }
        return !path.contains("sandboxReceipt")
        // return !(path.contains("CoreSimulator") || path.contains("sandboxReceipt"))
        #endif
    }
}
