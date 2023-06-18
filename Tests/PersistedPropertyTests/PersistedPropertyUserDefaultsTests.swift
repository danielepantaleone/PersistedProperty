//
//  PersistedPropertyUserDefaultsTests.swift
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

class PersistedPropertyUserDefaultsTests: PersistedPropertyTests {
    
    func testChangePersistedDoubleOnUserDefaults() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myUserDefaultsDouble, kDefaultUserDefaultsDouble)
        // Assert value change
        container.myUserDefaultsDouble = 20.0
        XCTAssertEqual(container.myUserDefaultsDouble, 20.0)
        XCTAssertEqual(container.$myUserDefaultsDouble.defaultValue, kDefaultUserDefaultsDouble)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsDouble))
    }
    
    func testChangePersistedStringOnUserDefaults() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myUserDefaultsString, kDefaultUserDefaultsString)
        // Assert value change
        container.myUserDefaultsString = "Lorem ipsum"
        XCTAssertEqual(container.myUserDefaultsString, "Lorem ipsum")
        XCTAssertEqual(container.$myUserDefaultsString.defaultValue, kDefaultUserDefaultsString)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsString))
    }
    
    func testChangePersistedStringOptionalOnUserDefaults() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertNil(container.myUserDefaultsStringOptional)
        // Assert value change
        container.myUserDefaultsStringOptional = "Lorem ipsum"
        XCTAssertEqual(try XCTUnwrap(container.myUserDefaultsStringOptional), "Lorem ipsum")
        XCTAssertNil(container.$myUserDefaultsStringOptional.defaultValue)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
        // Assert value clear
        container.myUserDefaultsStringOptional = nil
        XCTAssertNil(container.myUserDefaultsStringOptional)
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
    }
    
    func testChangePersistedEnumOnUserDefaults() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myUserDefaultsEnum, kDefaultUserDefaultsEnum)
        // Assert value change
        container.myUserDefaultsEnum = .four
        XCTAssertEqual(container.myUserDefaultsEnum, .four)
        XCTAssertEqual(container.$myUserDefaultsEnum.defaultValue, kDefaultUserDefaultsEnum)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsEnum))
    }
    
    func testChangePersistedEnumArrayOnUserDefaults() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myUserDefaultsEnumArray, kDefaultUserDefaultsEnumArray)
        // Assert value change
        container.myUserDefaultsEnumArray = [.three, .one]
        XCTAssertEqual(container.myUserDefaultsEnumArray, [.three, .one])
        XCTAssertEqual(container.$myUserDefaultsEnumArray.defaultValue, kDefaultUserDefaultsEnumArray)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsEnumArray))
    }
    
    func testChangePersistedStructOnUserDefaults() {
        let container = PersistedContainer()
        let persisted = PersistedStruct(a: 90.0, b: "Hello world", c: false, d: nil)
        // Assert default value
        XCTAssertNil(container.myUserDefaultsStruct)
        // Assert value change
        container.myUserDefaultsStruct = persisted
        XCTAssertEqual(container.myUserDefaultsStruct, persisted)
        XCTAssertNil(container.$myUserDefaultsStruct.defaultValue)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsStruct))
    }
    
    func testChangePersistedThrowableStructOnUserDefaults() {
        let container = PersistedContainer()
        let persisted = PersistedThrowableStruct(a: 90.0, b: "Lorem ipsum")
        // Assert default value
        XCTAssertEqual(container.myUserDefaultsThrowableStruct, kDefaultUserDefaultsThrowableStruct)
        // Assert value change
        container.myUserDefaultsThrowableStruct = persisted
        XCTAssertEqual(container.myUserDefaultsThrowableStruct, kDefaultUserDefaultsThrowableStruct)
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsThrowableStruct))
    }
    
}
