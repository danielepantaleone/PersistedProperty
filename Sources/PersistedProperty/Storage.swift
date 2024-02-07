//
//  Storage.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Define the storage to use when persisting properties.
public enum Storage {
    
    /// Storage service that persists values in the standard `UserDefaults`
    case standard
    /// Storage service that persists values in the iOS `KeyChain`
    case keychain
    /// Custom configured service.
    case custom(service: StorageService)
    
    // MARK: - Computed properties
    
    /// The service to be used for data persistence.
    internal var service: StorageService {
        switch self {
            case .standard:
                return UserDefaultsStorageService.shared
            case .keychain:
                return KeyChainStorageService.shared
            case .custom(let service):
                return service
        }
    }
    
}
