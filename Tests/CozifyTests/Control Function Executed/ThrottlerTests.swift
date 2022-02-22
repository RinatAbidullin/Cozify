//
//  ThrottlerTests.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import XCTest
@testable import Cozify

final class ThrottlerTests: XCTestCase {
    func testThrottle() throws {
        let promise = XCTestExpectation(description: "Throttler")
        
        var count = 0
        
        let throttler = Throttler()
        
        let throttleFunction = throttler.throttle(delay: .milliseconds(100)) {
            count += 1
        }
        
        throttleFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            XCTAssertEqual(count, 1)
        }
        
        throttleFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            throttleFunction()
            throttleFunction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                XCTAssertEqual(count, 1)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 2)
    }
    
    func testThrottleDurable() throws {
        let promise = XCTestExpectation(description: "Throttler")
        
        var count = 0
        
        let throttler = Throttler()
        
        let throttleFunction = throttler.throttle(delay: .milliseconds(100)) {
            count += 1
        }
        
        throttleFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            XCTAssertEqual(count, 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
            XCTAssertEqual(count, 1)
            throttleFunction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                XCTAssertEqual(count, 2)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(240)) {
            XCTAssertEqual(count, 2)
            throttleFunction()
            throttleFunction()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
                XCTAssertEqual(count, 3)
                throttleFunction()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 4)
    }
}
