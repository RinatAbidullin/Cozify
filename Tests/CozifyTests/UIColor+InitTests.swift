//
//  Cozify
//
//  Created by Rinat Abidullin on 12.12.2021.
//

import XCTest
@testable import Cozify

final class UIColorInitTests: XCTestCase {
    func testInitHexIntWhiteEqualWhite() throws {
        // Int hex
        let intColor = 0xffffff
        let colorFromInt = UIColor(hex: intColor)
        XCTAssertTrue(colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.white))
        
        // String hex
        let stringColor = "#ffffff"
        let colorFromString = UIColor(hex: stringColor)!
        XCTAssertTrue(colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.white))
    }
    
    func testInitHexIntBlackEqualBlack() throws {
        // Int hex
        let intColor = 0x000000
        let colorFromInt = UIColor(hex: intColor)
        XCTAssertTrue(colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.black))
        
        // String hex
        let stringColor = "#000000"
        let colorFromString = UIColor(hex: stringColor)!
        XCTAssertTrue(colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.black))
    }
    
    func testInitHexIntWhiteNotEqualBlack() throws {
        // Int hex
        let intColor = 0xffffff
        let colorFromInt = UIColor(hex: intColor)
        XCTAssertFalse(colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.black))
        
        // String hex
        let stringColor = "#ffffff"
        let colorFromString = UIColor(hex: stringColor)!
        XCTAssertFalse(colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.black))
    }
    
    func testInitHexIntBlackNotEqualWhite() throws {
        // Int hex
        let intColor = 0x000000
        let colorFromInt = UIColor(hex: intColor)
        XCTAssertFalse(colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.white))
        
        // String hex
        let stringColor = "#000000"
        let colorFromString = UIColor(hex: stringColor)!
        XCTAssertFalse(colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.white))
    }
    
    func testInitHexIntWhiteAlpha05EqualWhiteAlpha05() throws {
        // Int hex
        let intColor = 0xffffff
        let colorFromInt = UIColor(hex: intColor, alpha: 0.5)
        XCTAssertTrue(
            colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.white.withAlphaComponent(0.5))
        )
        
        // String hex
        let stringColor = "#ffffff"
        let colorFromString = UIColor(hex: stringColor, alpha: 0.5)!
        XCTAssertTrue(
            colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.white.withAlphaComponent(0.5))
        )
    }
    
    func testInitHexIntWhiteAlpha04EqualWhiteAlpha05() throws {
        // Int hex
        let intColor = 0xffffff
        let colorFromInt = UIColor(hex: intColor, alpha: 0.4)
        XCTAssertFalse(
            colorFromInt.isEqualAfterConvertsToSameColorSpace(UIColor.white.withAlphaComponent(0.5))
        )
        
        // String hex
        let stringColor = "#ffffff"
        let colorFromString = UIColor(hex: stringColor, alpha: 0.4)!
        XCTAssertFalse(
            colorFromString.isEqualAfterConvertsToSameColorSpace(UIColor.white.withAlphaComponent(0.5))
        )
    }
}
