//
//  PersistedPropertyTests.swift
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

class PersistedPropertyTests: XCTestCase {
    
    typealias Query = [CFString: Any]
    
    // MARK: - Properties

    lazy var bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "com.danielepantaleone.persisted-property"
    
    // MARK: - Initialization
    
    override func setUp() {
        deleteUserDefaults(key: kStorageUserDefaultsDouble)
        deleteUserDefaults(key: kStorageUserDefaultsString)
        deleteUserDefaults(key: kStorageUserDefaultsStringOptional)
        deleteUserDefaults(key: kStorageUserDefaultsEnum)
        deleteUserDefaults(key: kStorageUserDefaultsEnumArray)
        deleteUserDefaults(key: kStorageUserDefaultsStruct)
        deleteKeychain(key: kStorageKeyChainDouble)
        deleteKeychain(key: kStorageKeyChainPassword)
        deleteKeychain(key: kStorageKeyChainPasswordOptional)
        deleteInMemoryStorage()
    }
    
    override func tearDown() {
        deleteUserDefaults(key: kStorageUserDefaultsDouble)
        deleteUserDefaults(key: kStorageUserDefaultsString)
        deleteUserDefaults(key: kStorageUserDefaultsStringOptional)
        deleteUserDefaults(key: kStorageUserDefaultsEnum)
        deleteUserDefaults(key: kStorageUserDefaultsEnumArray)
        deleteUserDefaults(key: kStorageUserDefaultsStruct)
        deleteKeychain(key: kStorageKeyChainDouble)
        deleteKeychain(key: kStorageKeyChainPassword)
        deleteKeychain(key: kStorageKeyChainPasswordOptional)
        deleteInMemoryStorage()
    }
    
    // MARK: - Tests
    
    func testNoChangeMatchDefaults() {
        let container = PersistedContainer()
        // Check matching defaults
        XCTAssertEqual(container.myUserDefaultsDouble, kDefaultUserDefaultsDouble)
        XCTAssertEqual(container.myUserDefaultsString, kDefaultUserDefaultsString)
        XCTAssertEqual(container.myUserDefaultsEnum, kDefaultUserDefaultsEnum)
        XCTAssertEqual(container.myUserDefaultsEnumArray, kDefaultUserDefaultsEnumArray)
        XCTAssertNil(container.myUserDefaultsStringOptional)
        XCTAssertNil(container.myUserDefaultsStruct)
        XCTAssertEqual(container.myKeyChainDouble, kDefaultKeyChainDouble)
        XCTAssertEqual(container.myKeyChainPassword, kDefaultKeyChainPassword)
        XCTAssertNil(container.myKeyChainPasswordOptional)
        XCTAssertEqual(container.myInMemoryDouble, kDefaultInMemoryDouble)
        XCTAssertEqual(container.myInMemoryString, kDefaultInMemoryString)
        XCTAssertNil(container.myInMemoryStringOptional)
        // Check user defauls and keychain to be empty
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsDouble))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsString))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsEnum))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsEnumArray))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsStruct))
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainDouble))
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPassword))
        XCTAssertFalse(hasKeychain(key: kStorageKeyChainPasswordOptional))
    }
    
    // MARK: - Misc
    
    func hasKeychain(key: String, identifier: String = "default") -> Bool {
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
    
    func hasUserDefaults(key: String, userDefaults: UserDefaults = .standard) -> Bool {
        return userDefaults.data(forKey: key) != nil
    }
    
    func hasInMemory(key: String) -> Bool {
        if let storage = InMemoryStorageService.shared as? InMemoryStorageService {
            return storage.dictionary[key] != nil
        } else {
            return false
        }
    }
    
    func deleteUserDefaults(key: String, userDefaults: UserDefaults = .standard) {
        userDefaults.removeObject(forKey: key)
    }
    
    func deleteKeychain(key: String, identifier: String = "default") {
        SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: "\(bundleIdentifier).\(identifier)",
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrAccount: key
        ] as [CFString : Any] as CFDictionary)
    }
    
    func deleteInMemoryStorage() {
        if let storage = InMemoryStorageService.shared as? InMemoryStorageService {
            storage.dictionary.removeAll()
        }
    }
    
}
