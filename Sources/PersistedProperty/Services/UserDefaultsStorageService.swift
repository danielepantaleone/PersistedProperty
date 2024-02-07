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
    
    // MARK: - Shared
    
    /// Reference to the shared user defaults storage service.
    public static let shared: StorageService = UserDefaultsStorageService(userDefaults: .standard)
    
    // MARK: - Properties
    
    let mutex: Mutex = Mutex()
    let storageCoder: StorageCoder = StorageCoder()
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
            return storageCoder.decode(key: key, data: data)
        }
        return nil
    }
    
    public func save<ValueType>(_ value: ValueType, key: String) where ValueType: Codable {
        mutex.lock(type: .write)
        defer {
            mutex.unlock()
        }
        if let data = storageCoder.encode(key: key, value: value) {
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
