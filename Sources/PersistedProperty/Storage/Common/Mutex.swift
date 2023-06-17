//
//  Mutex.swift
//  PersistedProperty
//
//  Created by Daniele Pantaleone
//    - Github: https://github.com/danielepantaleone
//    - LinkedIn: https://www.linkedin.com/in/danielepantaleone
//
//  Copyright © 2023 Daniele Pantaleone. Licensed under MIT License.
//

import Foundation

/// Mutex implementation which make use of low level `pthread_rwlock_t`.
class Mutex {
    
    // MARK: - Properties
    
    var mutex = pthread_rwlock_t()
    
    // MARK: - Initialization
    
    /// Initialize the mutex.
    public init() {
        pthread_rwlock_init(&mutex, nil)
    }
    
    /// Destroy the mutex.
    deinit {
        pthread_rwlock_destroy(&mutex)
    }
    
    // MARK: - Interface
    
    /// Acquire the lock on the mutex.
    ///
    /// - parameters:
    ///   - type: The type of lock to acquire (either `.read` or `.write`)
    @inline(__always)
    public func lock(type: MutexType) {
        switch type {
            case .read:
                pthread_rwlock_rdlock(&mutex)
            case .write:
                pthread_rwlock_wrlock(&mutex)
        }
    }
    
    /// Release the lock from the mutex.
    @inline(__always)
    public func unlock() {
        pthread_rwlock_unlock(&mutex)
    }
    
    /// Execute the provided closure in a thread safe environment.
    ///
    /// - parameters:
    ///   - type: The type of lock to acquire (either `.read` or `.write`)
    @inline(never)
    public func sync<T>(type: MutexType, _ closure: () throws -> T) rethrows -> T {
        lock(type: type)
        defer { unlock() }
        return try closure()
    }
    
}
