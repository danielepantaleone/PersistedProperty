//
//  UserDefaultsStorageService.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation
import os

/// Basic storage service implementation that persists properties into `UserDefaults`.
open class UserDefaultsStorageService: StorageService {
    
    // MARK: - Properties
    
    let storageEncoder: StorageEncoder = StorageEncoder()
    let storageDecoder: StorageDecoder = StorageDecoder()
    let mutex: Mutex = Mutex()
    let userDefaults: UserDefaults
    
    // MARK: - Initialization
    
    /// Construct a new `UserDefaults` based storage service.
    ///
    /// - parameters:
    ///   - userDefaults: The instance of `UserDefaults` to use (default = `.standard`)
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // MARK: - Protocol implementation
    
    public func load<ValueType>(key: String) -> ValueType? where ValueType: Codable {
        mutex.lock(type: .read)
        defer {
            mutex.unlock()
        }
        if let data = userDefaults.data(forKey: key) {
            return storageDecoder.decode(key: key, data: data)
        }
        return nil
    }
    
    public func save<ValueType>(_ value: ValueType, key: String) where ValueType: Codable {
        mutex.lock(type: .write)
        defer {
            mutex.unlock()
        }
        if let data = storageEncoder.encode(key: key, value: value) {
            userDefaults.set(data, forKey: key)
        }
    }
    
    public func remove(key: String) {
        mutex.lock(type: .write)
        defer {
            mutex.unlock()
        }
        userDefaults.removeObject(forKey: key)
    }
    
}