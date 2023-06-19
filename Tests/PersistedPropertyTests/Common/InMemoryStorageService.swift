//
//  InMemoryStorageService.swift
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

class InMemoryStorageService: StorageService {
    
    // MARK: - Shared
    
    static let shared: StorageService = InMemoryStorageService()
    
    // MARK: - Properties
    
    var dictionary: [String: Any] = [:]
    
    // MARK: - Protocol implementation
    
    func load<ValueType>(key: String) -> ValueType? where ValueType: Codable {
        return dictionary[key] as? ValueType
    }
    
    func save<ValueType>(_ value: ValueType, key: String) where ValueType: Codable {
        dictionary[key] = value
    }
    
    func remove(key: String) {
        dictionary.removeValue(forKey: key)
    }
    
}
