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

let kDefaultUserDefaultsDouble: Double = 10.0
let kDefaultUserDefaultsString: String = "Hello world"
let kDefaultUserDefaultsEnum: UserDefaultsPersisted = .one
let kDefaultUserDefaultsEnumArray: [UserDefaultsPersisted] = [.one, .three]

let kStorageUserDefaultsDouble: String = "storage.double"
let kStorageUserDefaultsString: String = "storage.string"
let kStorageUserDefaultsStringOptional: String = "storage.string.optional"
let kStorageUserDefaultsEnum: String = "storage.enum"
let kStorageUserDefaultsEnumArray: String = "storage.enum.array"

// MARK: - UserDefaultsPersisted

enum UserDefaultsPersisted: Codable {
    case one
    case two
    case three
    case four
}

// MARK: - PersistedContainer

struct UserDefaultsPersistedContainer {
    @Persisted(key: kStorageUserDefaultsDouble, storage: .standard)
    var myDouble: Double = kDefaultUserDefaultsDouble
    @Persisted(key: kStorageUserDefaultsString, storage: .standard)
    var myString: String = kDefaultUserDefaultsString
    @Persisted(key: kStorageUserDefaultsStringOptional, storage: .standard)
    var myStringOptional: String? = nil
    @Persisted(key: kStorageUserDefaultsEnum, storage: .standard)
    var myEnum: UserDefaultsPersisted = kDefaultUserDefaultsEnum
    @Persisted(key: kStorageUserDefaultsEnumArray, storage: .standard)
    var myEnumArray: [UserDefaultsPersisted] = kDefaultUserDefaultsEnumArray
}

// MARK: - PersistedPropertyBuiltInTests

class PersistedPropertyUserDefaultsTests: XCTestCase {

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
    }
    
    // MARK: - Tests
    
    func testNoChangeMatchDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Check matching defaults
        XCTAssertEqual(container.myDouble, kDefaultUserDefaultsDouble)
        XCTAssertEqual(container.myString, kDefaultUserDefaultsString)
        XCTAssertEqual(container.myEnum, kDefaultUserDefaultsEnum)
        XCTAssertEqual(container.myEnumArray, kDefaultUserDefaultsEnumArray)
        XCTAssertNil(container.myStringOptional)
        // Check user defauls and keychain to be empty
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsDouble))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsString))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsEnum))
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsEnumArray))
    }
    
    func testChangePersistedDoubleOnUserDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myDouble, kDefaultUserDefaultsDouble)
        // Assert value change
        container.myDouble = 20.0
        XCTAssertEqual(container.myDouble, 20.0)
        XCTAssertEqual(container.$myDouble.defaultValue, kDefaultUserDefaultsDouble)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsDouble))
    }
    
    func testChangePersistedStringOnUserDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myString, kDefaultUserDefaultsString)
        // Assert value change
        container.myString = "Lorem ipsum"
        XCTAssertEqual(container.myString, "Lorem ipsum")
        XCTAssertEqual(container.$myString.defaultValue, kDefaultUserDefaultsString)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsString))
    }
    
    func testChangePersistedStringOptionalOnUserDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Assert default value
        XCTAssertNil(container.myStringOptional)
        // Assert value change
        container.myStringOptional = "Lorem ipsum"
        XCTAssertEqual(try XCTUnwrap(container.myStringOptional), "Lorem ipsum")
        XCTAssertNil(container.$myStringOptional.defaultValue)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
        // Assert value clear
        container.myStringOptional = nil
        XCTAssertNil(container.myStringOptional)
        XCTAssertFalse(hasUserDefaults(key: kStorageUserDefaultsStringOptional))
    }
    
    func testChangePersistedEnumOnUserDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myEnum, kDefaultUserDefaultsEnum)
        // Assert value change
        container.myEnum = .four
        XCTAssertEqual(container.myEnum, .four)
        XCTAssertEqual(container.$myEnum.defaultValue, kDefaultUserDefaultsEnum)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsEnum))
    }
    
    func testChangePersistedEnumArrayOnUserDefaults() {
        let container = UserDefaultsPersistedContainer()
        // Assert default value
        XCTAssertEqual(container.myEnumArray, kDefaultUserDefaultsEnumArray)
        // Assert value change
        container.myEnumArray = [.three, .one]
        XCTAssertEqual(container.myEnumArray, [.three, .one])
        XCTAssertEqual(container.$myEnumArray.defaultValue, kDefaultUserDefaultsEnumArray)
        XCTAssertTrue(hasUserDefaults(key: kStorageUserDefaultsEnumArray))
    }
    
    // MARK: - Misc
    
    private func hasUserDefaults(key: String, userDefaults: UserDefaults = .standard) -> Bool {
        return userDefaults.data(forKey: key) != nil
    }
    
    private func deleteUserDefaults(key: String, userDefaults: UserDefaults = .standard) {
        userDefaults.removeObject(forKey: key)
    }
    
}
