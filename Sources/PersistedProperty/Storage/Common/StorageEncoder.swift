//
//  StorageEncoder.swift
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

class StorageEncoder {
    
    // MARK: - Properties
    
    let jsonEncoder: JSONEncoder = JSONEncoder()
    let logger: OSLog = OSLog(subsystem: "com.danielepantaleone.persisted-property.storage-encoder", category: "")
    
    // MARK: - Interface
    
    func encode<ValueType>(key: String, value: ValueType) -> Data? where ValueType: Codable {
        do {
            return try jsonEncoder.encode(StorageWrapper(wrapped: value))
        } catch {
            os_log("Failed to encode value of type %@ using key %@: %@", type: .error, "\(type(of: ValueType.self))", key, error.localizedDescription)
        }
        return nil
    }
    
}
