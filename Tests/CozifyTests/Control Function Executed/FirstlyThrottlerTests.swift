//
//  FirstlyThrottlerTests.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import XCTest
@testable import Cozify

final class FirstlyThrottlerTests: XCTestCase {
    func testThrottleFirst() throws {
        let promise = XCTestExpectation(description: "FirstlyThrottler")
        
        var count = 0
        
        let firstlyThrottler = FirstlyThrottler()
        
        let throttleFunction = firstlyThrottler.throttleFirst(delay: .milliseconds(100)) {
            count += 1
        }
        
        throttleFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            XCTAssertEqual(count, 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(80)) {
            throttleFunction()
            throttleFunction()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 1)
    }
    
    func testThrottleFirstDurable() throws {
        let promise = XCTestExpectation(description: "FirstlyThrottler")
        
        var count = 0
        
        let firstlyThrottler = FirstlyThrottler()
        
        let throttleFunction = firstlyThrottler.throttleFirst(delay: .milliseconds(100)) {
            count += 1
        }
        
        throttleFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            XCTAssertEqual(count, 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
            XCTAssertEqual(count, 1)
            throttleFunction()
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
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 3)
    }
}
