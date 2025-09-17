//
//  isKeyboardExtensionEnabled.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public func isKeyboardExtensionEnabled() -> Bool {
    guard let appBundleIdentifier = Bundle.main.bundleIdentifier else {
        fatalError("isKeyboardExtensionEnabled(): Cannot retrieve bundle identifier.")
    }

    guard let keyboards = UserDefaults.standard.stringArray(forKey: "AppleKeyboards") else {
        // There is no key `AppleKeyboards` in NSUserDefaults. That happens sometimes.
        return false
    }

    let keyboardExtensionBundleIdentifierPrefix = appBundleIdentifier + "."
    for keyboard in keyboards {
        if keyboard.hasPrefix(keyboardExtensionBundleIdentifierPrefix) {
            return true
        }
    }

    return false
}
