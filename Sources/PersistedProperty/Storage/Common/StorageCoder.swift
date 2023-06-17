//
//  StorageCoder.swift
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

/// Helper utility class used to decode/encode a stored value from/to raw data.
class StorageCoder {
    
    /// Codable struct to wrap property values so that they can be persisted on iOS < 13
    /// https://stackoverflow.com/a/59475086/3477005
    struct Wrapper<ValueType>: Codable where ValueType: Codable {
        /// The wrapped value
        let wrapped: ValueType
    }
    
    // MARK: - Properties
    
    let jsonDecoder: JSONDecoder = JSONDecoder()
    let jsonEncoder: JSONEncoder = JSONEncoder()
    let osLogger: OSLog = OSLog(subsystem: "com.danielepantaleone.persisted-property.storage-coder", category: "")
    
    // MARK: - Interface
    
    /// Decode a property value from the given raw data.
    /// Will return `nil` if the decoding doesn't succeed.
    ///
    /// - parameters:
    ///   - key: The key used to map the value in the storag (for logging purpose only)
    ///   - data: Raw data from which to decode the value
    ///
    /// - returns: `ValueType?`
    func decode<ValueType>(key: String, data: Data) -> ValueType? where ValueType: Codable {
        do {
            return try jsonDecoder.decode(Wrapper<ValueType>.self, from: data).wrapped
        } catch {
            os_log("Failed to decode value of type %@ using key %@: %@", type: .error, "\(type(of: ValueType.self))", key, error.localizedDescription)
        }
        return nil
    }
    
    /// Encode a property value into raw data.
    /// Will return `nil` if the encoding doesn't succeed.
    ///
    /// - parameters:
    ///   - key: The key used to map the value in the storag (for logging purpose only)
    ///   - value: The value to encode
    ///
    /// - returns: `Data`
    func encode<ValueType>(key: String, value: ValueType) -> Data? where ValueType: Codable {
        do {
            return try jsonEncoder.encode(Wrapper(wrapped: value))
        } catch {
            os_log("Failed to encode value of type %@ using key %@: %@", type: .error, "\(type(of: ValueType.self))", key, error.localizedDescription)
        }
        return nil
    }
    
}
