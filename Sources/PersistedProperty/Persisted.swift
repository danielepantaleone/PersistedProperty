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

/// Property wrapper to make properties persistable in a pre-configured storage.
/// In order to mark a property with `@Persisted` the property type must conform to the `Codable` protocol.
///
/// Typical usage would be to decorate a property, providing a storage key:
///
/// ```swift
/// @Persisted(key: "storage.property")
/// var aProperty: Double = 10.0
/// ```
///
/// You can optionally specify the desired storage to use when configuring the property wrapper.
/// If you don't, a default storage backed by the standard `UserDefaults` will be used.
///
/// ```swift
/// @Persisted(key: "storage.password", storage: .keychain)
/// var aPassword: String = "abcdefghijklmnopqrstuvwxyz"
/// ```
/// You can also create your own storage by conforming to the `StorageService` protocol
/// and specifying the `.custom(service: StorageService)` storage when configuring the
/// property wrapper:
///
/// ```swift
/// let myService: StorageService = MyStorageService()
///
/// @Persisted(key: "storage.anotherProperty", storage: .custom(service: myService))
/// var anotherProperty: String = "abcdefghijklmnopqrstuvwxyz"
/// ```
@propertyWrapper
public struct Persisted<ValueType: Codable> {
    
    // MARK: - Private properties
    
    /// The keyword used to persist the value in the storage.
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
        nonmutating set {
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
    ///   - storage: The storage to use (default to `.standard`)
    public init(wrappedValue: ValueType, key: String, storage: Storage = .standard) {
        self.defaultValue = wrappedValue
        self.key = key
        self.storage = storage
    }
    
}
