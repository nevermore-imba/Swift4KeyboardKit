//
//  KeyboardKeyViewSet.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/13/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardKeyViewSet {

    private var viewsByKey: [KeyboardKey: KeyboardKeyView] = [:]
    private var keysByView: [KeyboardKeyView: KeyboardKey] = [:]

    internal var views: [KeyboardKeyView] {
        return Array(self.viewsByKey.values)
    }

    internal var keys: [KeyboardKey] {
        return Array(self.keysByView.values)
    }

    internal func insert(_ key: KeyboardKey, keyView: KeyboardKeyView) {
        self.viewsByKey[key] = keyView
        self.keysByView[keyView] = key
        self.touch()
    }

    internal func remove(key: KeyboardKey) {
        guard let keyView = self.viewsByKey[key] else { return }
        self.viewsByKey.removeValue(forKey: key)
        self.keysByView.removeValue(forKey: keyView)
        self.touch()
    }

    internal func remove(keyView: KeyboardKeyView) {
        guard let key = self.keysByView[keyView] else { return }
        self.viewsByKey.removeValue(forKey: key)
        self.keysByView.removeValue(forKey: keyView)
        self.touch()
    }

    internal func removeAll() {
        self.viewsByKey.removeAll()
        self.keysByView.removeAll()
        self.touch()
    }

    internal func viewByKey(_ key: KeyboardKey) -> KeyboardKeyView? {
        return self.viewsByKey[key]
    }

    internal func keyByView(_ keyView: KeyboardKeyView) -> KeyboardKey? {
        return self.keysByView[keyView]
    }

    private var internalHashValue: Int = 0
    private func touch() {
        self.internalHashValue += 1
    }
}


extension KeyboardKeyViewSet: Sequence {

    internal func makeIterator() -> Dictionary<KeyboardKey, KeyboardKeyView>.Iterator {
        return self.viewsByKey.makeIterator()
    }

}


extension KeyboardKeyViewSet: Hashable {

    internal static func == (lhs: KeyboardKeyViewSet, rhs: KeyboardKeyViewSet) -> Bool {
        return
            lhs.viewsByKey == rhs.viewsByKey &&
            lhs.keysByView == rhs.keysByView
    }

    internal func hash(into hasher: inout Hasher) {
        hasher.combine(viewsByKey)
        hasher.combine(keysByView)
        hasher.combine(internalHashValue)
    }
}

extension KeyboardKeyViewPool {

    internal func storeSet(_ keyViewSet: KeyboardKeyViewSet) {
        for (key, keyView) in keyViewSet {
            self.store(keyView: keyView, keyType: key.type)
        }
    }

}
