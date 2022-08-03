//
//  File.swift
//  
//
//  Created by Rinat Abidullin on 03.08.2022.
//

import XCTest
@testable import Cozify

final class StringAppendingFilePathComponent: XCTestCase {
    func testAppendingFilePathComponent() throws {
        let pathsSet = [
            (initialPath: "", pathComponent: "scratch.tiff", expectedPath: "scratch.tiff"),
            (initialPath: "/", pathComponent: "scratch.tiff", expectedPath: "/scratch.tiff"),
            (initialPath: "/tmp", pathComponent: "scratch.tiff", expectedPath: "/tmp/scratch.tiff"),
            (initialPath: "/tmp/", pathComponent: "scratch.tiff", expectedPath: "/tmp/scratch.tiff"),
            (initialPath: "tmp/", pathComponent: "scratch.tiff", expectedPath: "tmp/scratch.tiff"),
            (initialPath: "tmp", pathComponent: "scratch.tiff", expectedPath: "tmp/scratch.tiff"),
            
            (initialPath: "", pathComponent: "/scratch.tiff", expectedPath: "scratch.tiff"),
            (initialPath: "/", pathComponent: "/scratch.tiff", expectedPath: "/scratch.tiff"),
            (initialPath: "/tmp", pathComponent: "/scratch.tiff", expectedPath: "/tmp/scratch.tiff"),
            (initialPath: "/tmp/", pathComponent: "/scratch.tiff", expectedPath: "/tmp/scratch.tiff"),
            (initialPath: "tmp/", pathComponent: "/scratch.tiff", expectedPath: "tmp/scratch.tiff"),
            (initialPath: "tmp", pathComponent: "/scratch.tiff", expectedPath: "tmp/scratch.tiff")
        ]
        
        for element in pathsSet {
            let initialPath = element.initialPath
            let transformedPath = initialPath.appending(filePathComponent: element.pathComponent)
            let expectedPath = element.expectedPath
            XCTAssertEqual(transformedPath, expectedPath)
        }
    }
}
