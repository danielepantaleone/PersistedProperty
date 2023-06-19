//
//  PersistedContainer.swift
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
let kDefaultUserDefaultsDouble: Double = 10.0
let kDefaultUserDefaultsString: String = "Hello world"
let kDefaultUserDefaultsEnum: PersistedEnum = .one
let kDefaultUserDefaultsEnumArray: [PersistedEnum] = [.one, .three]
let kDefaultUserDefaultsThrowableStruct: PersistedThrowableStruct = PersistedThrowableStruct(a: 10.0, b: "Hello world")
let kDefaultInMemoryDouble: Double = 70.0
let kDefaultInMemoryString: String = "Lorem iopsum"

let kStorageKeyChainDouble: String = "storage.double"
let kStorageKeyChainPassword: String = "storage.password"
let kStorageKeyChainPasswordOptional: String = "storage.password.optional"
let kStorageUserDefaultsDouble: String = "storage.double"
let kStorageUserDefaultsString: String = "storage.string"
let kStorageUserDefaultsStringOptional: String = "storage.string.optional"
let kStorageUserDefaultsEnum: String = "storage.enum"
let kStorageUserDefaultsEnumArray: String = "storage.enum.array"
let kStorageUserDefaultsStruct: String = "storage.struct"
let kStorageUserDefaultsThrowableStruct: String = "storage.struct.throwable"
let kStorageInMemoryDouble: String = "storage.double"
let kStorageInMemoryString: String = "storage.string"
let kStorageInMemoryStringOptional: String = "storage.string.optional"


// MARK: - PersistedEnum

enum PersistedEnum: Codable {
    case one
    case two
    case three
    case four
}

// MARK: - PersistedStruct

struct PersistedStruct: Codable, Equatable {
    let a: Double
    let b: String
    let c: Bool
    let d: String?
}

// MARK: - PersistedThrowableStruct

enum PersistedError: Error {
    case testError
}

struct PersistedThrowableStruct: Codable, Equatable {
    
    let a: Double
    let b: String
    
    enum CodingKeys: String, CodingKey {
        case a
        case b
    }
    
    init(a: Double, b: String) {
        self.a = a
        self.b = b
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.a = try container.decode(Double.self, forKey: .a)
        self.b = try container.decode(String.self, forKey: .b)
    }
    
    func encode(to encoder: Encoder) throws {
        throw PersistedError.testError
    }
    
}

// MARK: - PersistedContainer

struct PersistedContainer {
    
    // MARK: - KeyChain
    
    @Persisted(key: kStorageKeyChainDouble, storage: .keychain)
    var myKeyChainDouble: Double = kDefaultKeyChainDouble
    @Persisted(key: kStorageKeyChainPassword, storage: .keychain)
    var myKeyChainPassword: String = kDefaultKeyChainPassword
    @Persisted(key: kStorageKeyChainPasswordOptional, storage: .keychain)
    var myKeyChainPasswordOptional: String? = nil
    
    // MARK: - UserDefaults
    
    @Persisted(key: kStorageUserDefaultsDouble, storage: .standard)
    var myUserDefaultsDouble: Double = kDefaultUserDefaultsDouble
    @Persisted(key: kStorageUserDefaultsString, storage: .standard)
    var myUserDefaultsString: String = kDefaultUserDefaultsString
    @Persisted(key: kStorageUserDefaultsStringOptional, storage: .standard)
    var myUserDefaultsStringOptional: String? = nil
    @Persisted(key: kStorageUserDefaultsEnum, storage: .standard)
    var myUserDefaultsEnum: PersistedEnum = kDefaultUserDefaultsEnum
    @Persisted(key: kStorageUserDefaultsEnumArray, storage: .standard)
    var myUserDefaultsEnumArray: [PersistedEnum] = kDefaultUserDefaultsEnumArray
    @Persisted(key: kStorageUserDefaultsStruct, storage: .standard)
    var myUserDefaultsStruct: PersistedStruct? = nil
    @Persisted(key: kStorageUserDefaultsThrowableStruct, storage: .standard)
    var myUserDefaultsThrowableStruct: PersistedThrowableStruct = kDefaultUserDefaultsThrowableStruct
    
    @Persisted(key: kStorageInMemoryDouble, storage: .custom(service: InMemoryStorageService.shared))
    var myInMemoryDouble: Double = kDefaultInMemoryDouble
    @Persisted(key: kStorageInMemoryString, storage: .custom(service: InMemoryStorageService.shared))
    var myInMemoryString: String = kDefaultInMemoryString
    @Persisted(key: kStorageInMemoryStringOptional, storage: .custom(service: InMemoryStorageService.shared))
    var myInMemoryStringOptional: String? = nil

}
