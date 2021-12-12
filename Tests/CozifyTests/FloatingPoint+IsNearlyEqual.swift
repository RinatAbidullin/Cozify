//
//  Cozify
//
//  Created by Rinat Abidullin on 12.12.2021.
//

import XCTest
@testable import Cozify

final class FloatingPointIsNearlyEqualTests: XCTestCase {
    func testNearlyEqual() throws {
        let firstNumber: Float =  125.000001
        let secondNumber: Float = 125.000003
        XCTAssertTrue(firstNumber.isNearlyEqual(to: secondNumber))
    }
    
    func testNearlyEqual2() throws {
        let firstNumber: Double =  125.00000000000001
        let secondNumber: Double = 125.00000000000002
        XCTAssertTrue(firstNumber.isNearlyEqual(to: secondNumber))
    }
}
