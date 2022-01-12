//
//  EnvironmentTests.swift
//  
//
//  Created by Rinat Abidullin on 12.01.2022.
//

import XCTest
@testable import Cozify

final class EnvironmentTests: XCTestCase {
    func testIsSimulator() throws {
        XCTAssertTrue(Environment.isSimulator)
    }
    
    func testIsUnitTest() throws {
        XCTAssertTrue(Environment.isUnitOrUiTest)
    }
    
    func testIsDebug() throws {
        XCTAssertTrue(Environment.isDebug)
    }
    
    func testIsTestFlight() throws {
        XCTAssertFalse(Environment.isTestFlight)
    }
    
    func testIsProduction() throws {
        XCTAssertFalse(Environment.isProduction)
    }
}
