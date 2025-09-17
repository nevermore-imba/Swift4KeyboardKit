//
//  KeyboardKeyAppearanceVariant.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardKeyAppearanceVariant {
    public var keyType: KeyboardKeyType = .Character
    public var keyColorType: KeyboardKeyColorType = .Regular
    public var popupType: KeyboardKeyPopupType = .None
    public var keyMode: KeyboardKeyMode = KeyboardKeyMode()
    public var keyboardMode: KeyboardMode = KeyboardMode()
}


extension KeyboardKeyAppearanceVariant {
    public static func suitable() -> KeyboardKeyAppearanceVariant {
        var keyAppearanceVariant = KeyboardKeyAppearanceVariant()
        keyAppearanceVariant.keyboardMode.colorMode = KeyboardColorMode.suitable()
        keyAppearanceVariant.keyboardMode.sizeMode = KeyboardSizeMode.suitable()
        return keyAppearanceVariant
    }

    mutating func synchronizeModes() {
        if self.keyType == .Shift && self.keyboardMode.shiftMode.needCapitalize() {
            self.keyMode.selectionMode = .Selected
        }
    }
}


extension KeyboardKeyAppearanceVariant: Equatable {}
extension KeyboardKeyAppearanceVariant: Hashable {}
