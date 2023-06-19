//
//  PersistedPropertyInMemoryTests.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import XCTest

@testable import PersistedProperty

class PersistedPropertyInMemoryTests: PersistedPropertyTests {
    
    func testChangePersistedDoubleInMemory() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myInMemoryDouble, kDefaultInMemoryDouble)
        // Assert value change
        container.myInMemoryDouble = 20.0
        XCTAssertEqual(container.myInMemoryDouble, 20.0)
        XCTAssertEqual(container.$myInMemoryDouble.defaultValue, kDefaultInMemoryDouble)
        XCTAssertTrue(hasInMemory(key: kStorageInMemoryDouble))
    }
    
    func testChangePersistedStringInMemory() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myInMemoryString, kDefaultInMemoryString)
        // Assert value change
        container.myInMemoryString = "Hello world"
        XCTAssertEqual(container.myInMemoryString, "Hello world")
        XCTAssertEqual(container.$myInMemoryString.defaultValue, kDefaultInMemoryString)
        XCTAssertTrue(hasInMemory(key: kStorageInMemoryString))
    }
    
    func testChangePersistedStringOptionalInMemory() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertNil(container.myInMemoryStringOptional)
        // Assert value change
        container.myInMemoryStringOptional = "The quick brown fox"
        XCTAssertEqual(try XCTUnwrap(container.myInMemoryStringOptional), "The quick brown fox")
        XCTAssertNil(container.$myInMemoryStringOptional.defaultValue)
        XCTAssertTrue(hasInMemory(key: kStorageInMemoryStringOptional))
        // Assert value clear
        container.myInMemoryStringOptional = nil
        XCTAssertNil(container.myInMemoryStringOptional)
        XCTAssertFalse(hasInMemory(key: kStorageInMemoryStringOptional))
    }
    
}
