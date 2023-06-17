//
//  KeyChainStorageService.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Storage service implementation that persists properties into the iOS `KeyChain`.
open class KeyChainStorageService: StorageService {
    
    typealias Query = [CFString: Any]
    
    // MARK: - Properties
    
    let identifier: String
    let storageEncoder: StorageEncoder = StorageEncoder()
    let storageDecoder: StorageDecoder = StorageDecoder()
    let mutex: Mutex = Mutex()
    
    // MARK: - Computed properties
    
    var serviceName: String { "com.danielepantaleone.persisted-property.\(identifier)"}
    
    // MARK: - Initialization
    
    /// Initialize the keychain storage service.
    ///
    /// - parameters:
    ///   - identifier: store's unique identifier.
    public init(identifier: String = "default") {
        self.identifier = identifier
    }
    
    // MARK: - Protocol implementation
    
    public func load<ValueType>(key: String) -> ValueType? where ValueType: Codable {
        mutex.lock(type: .read)
        defer {
            mutex.unlock()
        }
        let query: Query = makeQuery(with: key) {
            $0[kSecReturnData] = kCFBooleanTrue
            $0[kSecMatchLimit] = kSecMatchLimitOne
        }
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        guard status == noErr else {
            return nil
        }
        guard let data = dataTypeRef as? Data else {
            return nil
        }
        return storageDecoder.decode(key: key, data: data)
    }
    
    public func save<ValueType>(_ value: ValueType, key: String) where ValueType: Codable {
        mutex.lock(type: .write)
        defer {
            mutex.unlock()
        }
        if let data = storageEncoder.encode(key: key, value: value) {
            let query: Query = makeQuery(with: key) {
                $0[kSecValueData] = data
            }
            SecItemDelete(query as CFDictionary)
            SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    public func remove(key: String) {
        mutex.lock(type: .write)
        defer {
            mutex.unlock()
        }
        let query: Query = makeQuery(with: key)
        SecItemDelete(query as CFDictionary)
    }
    
    // MARK: - Internal
    
    func makeQuery(with key: String, mutator: ((inout Query) -> Void)? = nil) -> Query {
        var query: Query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceName,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            kSecAttrAccount: key
        ]
        mutator?(&query)
        return query
    }
    
}
