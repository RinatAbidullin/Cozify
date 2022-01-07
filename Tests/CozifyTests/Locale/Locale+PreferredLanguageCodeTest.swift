//
//  Locale+PreferredLanguageCodeTest.swift
//  
//
//  Created by Rinat Abidullin on 07.01.2022.
//

import XCTest
@testable import Cozify

final class LocalePreferredLanguageCodeTest: XCTestCase {
    func testCountryCode() throws {
        guard let countryCode = Locale.preferredLanguageCode else {
            XCTFail()
            return
        }
        XCTAssertEqual(countryCode.count, 2)
    }
}
