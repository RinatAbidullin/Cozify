//
//  DebouncerTests.swift
//  
//
//  Created by Rinat Abidullin on 22.02.2022.
//

import XCTest
@testable import Cozify

final class DebouncerTests: XCTestCase {
    func testDebouncer() throws {
        let promise = XCTestExpectation(description: "Debouncer")
        
        var count = 0
        
        let debouncer = Debouncer()
        
        let debouncerFunction = debouncer.debounce(delay: .milliseconds(100)) {
            count += 1
        }
        
        debouncerFunction()
        debouncerFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            debouncerFunction()
            debouncerFunction()
            XCTAssertEqual(count, 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(180)) {
            XCTAssertEqual(count, 1) // 180 - 50 = 130 ms > 100 ms
            debouncerFunction()
            debouncerFunction()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 2)
    }
    
    func testDebouncerDurable() throws {
        let promise = XCTestExpectation(description: "Debouncer")
        
        var count = 0
        
        let debouncer = Debouncer()
        
        let debouncerFunction = debouncer.debounce(delay: .milliseconds(100)) {
            count += 1
        }
        
        debouncerFunction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(5)) {
            XCTAssertEqual(count, 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
            XCTAssertEqual(count, 1)
            debouncerFunction()
            debouncerFunction()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(240)) {
            XCTAssertEqual(count, 2)
            debouncerFunction()
            debouncerFunction()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
        
        XCTAssertEqual(count, 3)
    }
}
