//
//  StorageService.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// A protocol that defines a storage service where to persist properties.
public protocol StorageService {
            
    /// Load the property value from storage.
    ///
    /// - parameters:
    ///   - key: The key used to map the property value in the storage
    ///
    /// - returns: `ValueType`
    func load<ValueType>(key: String) -> ValueType? where ValueType: Codable
    
    /// Save the property value into the storage.
    ///
    /// - parameters:
    ///   - value: The value to be persisted
    ///   - key: The key used to map the property value in the storage
    func save<ValueType>(_ value: ValueType, key: String) where ValueType: Codable
    
    /// Remove any value persisted on the given storage key.
    ///
    /// - parameters:
    ///   - key: The key used to map the property value in the storage
    func remove(key: String)
    
}
