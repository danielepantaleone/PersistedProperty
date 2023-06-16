//
//  MutexType.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Enumeration that lists available access types.
enum MutexType {
    /// Denote read access on the mutex: concurrent reads are possible.
    case read
    /// Denote write access on the mutex: no other writes or read may happen.
    case write
}
