//
//  WeakBox.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal struct WeakBox<T> {

    internal private(set) weak var value: AnyObject?
    internal let id: ObjectIdentifier

    internal init(_ value: T) {
        let object = value as AnyObject
        self.value = object
        self.id = ObjectIdentifier(object)
    }
}


extension WeakBox: Hashable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return rhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

public struct WeakSet<Element>: Sequence {

    private var boxes = Set<WeakBox<Element>>()

    public init() {}

    /// 清理已释放对象
    private mutating func cleanup() {
        boxes = boxes.filter { $0.value != nil }
    }

    public mutating func insert(_ object: Element) {
        cleanup()
        boxes.insert(WeakBox(object))
    }

    public mutating func remove(_ object: Element) {
        cleanup()
        boxes.remove(WeakBox(object))
    }

    public mutating func removeAll() {
        boxes.removeAll()
    }

    public func contains(_ object: Element) -> Bool {
        return boxes.contains(WeakBox(object))
    }
    
    public func makeIterator() -> AnyIterator<Element> {
        // 创建数组快照，避免迭代中被修改
        let values = boxes.compactMap { $0.value as? Element }
        var index = 0
        return AnyIterator {
            guard index < values.count else { return nil }
            let val = values[index]
            index += 1
            return val
        }
    }

    public var first: Element? {
        return self.makeIterator().next()
    }
}
