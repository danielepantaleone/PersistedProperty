//
//  PersistedPropertyKeyChainTests.swift
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

class PersistedPropertyKeyChainTests: PersistedPropertyTests {
    
    func testChangePersistedDoubleOnKeychain() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myKeyChainDouble, kDefaultKeyChainDouble)
        // Assert value change
        container.myKeyChainDouble = 0.0
        XCTAssertEqual(container.myKeyChainDouble, 0.0)
        XCTAssertEqual(container.$myKeyChainDouble.defaultValue, kDefaultKeyChainDouble)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainDouble))
    }
    
    func testChangePersistedPasswordOnKeychain() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myKeyChainPassword, kDefaultKeyChainPassword)
        // Assert value change
        container.myKeyChainPassword = "123456789"
        XCTAssertEqual(container.myKeyChainPassword, "123456789")
        XCTAssertEqual(container.$myKeyChainPassword.defaultValue, kDefaultKeyChainPassword)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainPassword))
    }
    
    func testChangePersistedPasswordOptionalOnKeychain() {
        let container = PersistedContainer()
        // Assert default value
        XCTAssertNil(container.myKeyChainPasswordOptional)
        // Assert value change
        container.myKeyChainPasswordOptional = "123456789"
        XCTAssertEqual(container.myKeyChainPasswordOptional, "123456789")
        XCTAssertNil(container.$myKeyChainPasswordOptional.defaultValue)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainPasswordOptional))
        // Assert value clear
        container.myKeyChainPasswordOptional = nil
        XCTAssertNil(container.myKeyChainPasswordOptional)
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPasswordOptional))
    }
    
}
