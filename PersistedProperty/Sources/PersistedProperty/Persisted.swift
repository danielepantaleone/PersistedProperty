//
//  Persisted.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Property wrapper to make properties persistable.
///
/// A typical usege would be to decorate a property, providing a storage keyword and a default value:
///
/// ```
/// @Persisted(key: "storage.keyword")
/// var myProperty: Double = 10.0
/// ```
@propertyWrapper
public class Persisted<ValueType: Codable & Equatable> {
    
    // MARK: - Private properties
    
    /// The keyword used to persist the value in local storage.
    private let key: String
    /// The storage where to persist the value.
    private let storage: Storage
    
    // MARK: - Public properties
    
    /// The default value.
    public let defaultValue: ValueType
    /// The value behind the persisted value.
    public var wrappedValue: ValueType {
        get {
            if let value: ValueType = storage.service.load(key: key) {
                return value
            }
            return defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.service.remove(key: key)
            } else {
                storage.service.save(newValue, key: key)
            }
        }
    }
    
    // MARK: - Initialization
    
    /// Construct a new Persisted property.
    ///
    /// - parameters:
    ///   - wrappedValue: The default value for this persisted property
    ///   - key: A key used to persist the property on the storage service
    ///   - storage: The storage to use
    ///   - persistenceStrategy: The strategy used to determine when the value should be retrieved from disk and when is has to be persisted.
    public init(wrappedValue: ValueType, key: String, storage: Storage = .standard) {
        self.defaultValue = wrappedValue
        self.key = key
        self.storage = storage
    }
    
}
