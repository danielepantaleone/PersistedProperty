//
//  StorageDecoder.swift
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

class StorageDecoder {
    
    // MARK: - Properties
    
    let jsonDecoder: JSONDecoder = JSONDecoder()
    let logger: OSLog = OSLog(subsystem: "com.danielepantaleone.persisted-property.storage-decoder", category: "")
    
    // MARK: - Interface
    
    func decode<ValueType>(key: String, data: Data) -> ValueType? where ValueType: Codable {
        do {
            return try jsonDecoder.decode(StorageWrapper<ValueType>.self, from: data).wrapped
        } catch {
            os_log("Failed to decode value of type %@ using key %@: %@", type: .error, "\(type(of: ValueType.self))", key, error.localizedDescription)
        }
        return nil
    }
    
}
