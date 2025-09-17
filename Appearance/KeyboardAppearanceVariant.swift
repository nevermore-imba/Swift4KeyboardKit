//
//  KeyboardAppearanceVariant.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardAppearanceVariant {
    public var colorMode: KeyboardColorMode = .Light
    public var vibrancyMode: KeyboardVibrancyMode = .Transparent
    public var sizeMode: KeyboardSizeMode = .Small
}


extension KeyboardAppearanceVariant {
    static func suitable() -> KeyboardAppearanceVariant {
        var appearanceVariant = KeyboardAppearanceVariant()
        appearanceVariant.colorMode = KeyboardColorMode.suitable()
        appearanceVariant.sizeMode = KeyboardSizeMode.suitable()
        return appearanceVariant
    }
}


extension KeyboardAppearanceVariant: Equatable {}
extension KeyboardAppearanceVariant: Hashable {}
