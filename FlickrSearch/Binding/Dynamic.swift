//
//  Dynamic.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import Foundation

/// This type should be used for view model variables. It realizes a one direction binding.
public class Dynamic<T> {

    public typealias Listener = (T) -> Void
    fileprivate var listener: Listener?

    /// Wrapped value
    public var value: T {
        didSet {
            listener?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func notifyListener() {
        listener?(value)
    }

    /**
     Bind value with passed function.

     - parameter listener: Function which is invoked everytime the value changes
     */
    public func bind(listener: @escaping Listener) {
        self.listener = listener
    }

    /**
     Binds value with passed function and invokes function.

     - parameter listener: Function which is invoked everytime the value changes
     */
    public func bindAndFire(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }

    public func removeListener() {
        listener = nil
    }
}
