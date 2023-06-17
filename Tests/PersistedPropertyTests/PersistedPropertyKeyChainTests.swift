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

let kDefaultKeyChainDouble: Double = 80.0
let kDefaultKeyChainPassword: String = "CKPmwZ529rUbGqFP"

let kStorageKeyChainDouble: String = "storage.double"
let kStorageKeyChainPassword: String = "storage.password"
let kStorageKeyChainPasswordOptional: String = "storage.password.optional"

// MARK: - KeyChainPersistedContainer

struct KeyChainPersistedContainer {
    @Persisted(key: kStorageKeyChainDouble, storage: .keychain)
    var myDouble: Double = kDefaultKeyChainDouble
    @Persisted(key: kStorageKeyChainPassword, storage: .keychain)
    var myPassword: String = kDefaultKeyChainPassword
    @Persisted(key: kStorageKeyChainPasswordOptional, storage: .keychain)
    var myPasswordOptional: String? = nil
}

// MARK: - PersistedPropertyKeyChainTests

class PersistedPropertyKeyChainTests: XCTestCase {

    typealias Query = [CFString: Any]
    
    // MARK: - Properties

    lazy var bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "com.danielepantaleone.persisted-property"
    
    // MARK: - Initialization
    
    override func setUp() {
        deleteKeychain(key: kStorageKeyChainDouble)
        deleteKeychain(key: kStorageKeyChainPassword)
        deleteKeychain(key: kStorageKeyChainPasswordOptional)
    }
    
    override func tearDown() {
        deleteKeychain(key: kStorageKeyChainDouble)
        deleteKeychain(key: kStorageKeyChainPassword)
        deleteKeychain(key: kStorageKeyChainPasswordOptional)
    }
    
    // MARK: - Tests
    
    func testNoChangeMatchDefaults() {
        let container = KeyChainPersistedContainer()
        // Check matching defaults
        XCTAssertEqual(container.myDouble, kDefaultKeyChainDouble)
        XCTAssertEqual(container.myPassword, kDefaultKeyChainPassword)
        XCTAssertNil(container.myPasswordOptional)
        // Check keychain to be empty
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainDouble))
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPassword))
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPasswordOptional))
    }
    
    func testChangePersistedDoubleOnKeychain() {
        let container = KeyChainPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myDouble, kDefaultKeyChainDouble)
        // Assert value change
        container.myDouble = 0.0
        XCTAssertEqual(container.myDouble, 0.0)
        XCTAssertEqual(container.$myDouble.defaultValue, kDefaultKeyChainDouble)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainDouble))
    }
    
    func testChangePersistedPasswordOnKeychain() {
        let container = KeyChainPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myPassword, kDefaultKeyChainPassword)
        // Assert value change
        container.myPassword = "123456789"
        XCTAssertEqual(container.myPassword, "123456789")
        XCTAssertEqual(container.$myPassword.defaultValue, kDefaultKeyChainPassword)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainPassword))
    }
    
    func testChangePersistedPasswordOptionalOnKeychain() {
        let container = KeyChainPersistedContainer()
        // Assert default value
        XCTAssertNil(container.myPasswordOptional)
        // Assert value change
        container.myPasswordOptional = "123456789"
        XCTAssertEqual(container.myPasswordOptional, "123456789")
        XCTAssertNil(container.$myPasswordOptional.defaultValue)
        XCTAssertTrue(hasKeychain(key: kStorageKeyChainPasswordOptional))
        // Assert value clear
        container.myPasswordOptional = nil
        XCTAssertNil(container.myPasswordOptional)
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPasswordOptional))
    }
    
    // MARK: - Misc
    
    private func hasKeychain(key: String, identifier: String = "default") -> Bool {
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching([
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "\(bundleIdentifier).\(identifier)",
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrAccount: key
        ] as [CFString : Any] as CFDictionary, &dataTypeRef)
        guard status == noErr else {
            return false
        }
        guard dataTypeRef is Data else {
            return false
        }
        return true
    }
    
    private func deleteKeychain(key: String, identifier: String = "default") {
        SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "\(bundleIdentifier).\(identifier)",
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrAccount: key
        ] as [CFString : Any] as CFDictionary)
    }
    
}
