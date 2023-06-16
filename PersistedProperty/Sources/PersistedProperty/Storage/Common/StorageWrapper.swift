//
//  StorageWrapper.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Codable struct to wrap property values so that they can be persisted on iOS < 13
/// https://stackoverflow.com/a/59475086/3477005
struct StorageWrapper<ValueType>: Codable where ValueType: Codable {
    /// The wrapped value
    let wrapped: ValueType
}
