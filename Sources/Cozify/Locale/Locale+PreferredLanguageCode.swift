//
//  Locale+PreferredLanguageCode.swift
//  
//
//  Created by Rinat Abidullin on 07.01.2022.
//

import Foundation

public extension Locale {
    static var preferredLanguageCode: String? {
        if
            let preferredLanguage = Locale.preferredLanguages.first,
            let languageCode = Locale.components(
                fromIdentifier: preferredLanguage
            )[NSLocale.Key.languageCode.rawValue]
        {
            return languageCode
        }
        return nil
    }
}
