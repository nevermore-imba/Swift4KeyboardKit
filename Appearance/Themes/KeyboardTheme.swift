//
//  KeyboardTheme.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardTheme {
    // # Keyboard
    func keyboardBackgroundColorWithAppearanceVariant(_ appearanceVariant: KeyboardAppearanceVariant) -> UIColor

    // # Keycap
    func keycapBodyColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapTextColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapBorderColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapOuterShadowColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func keycapBorderSizeWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat

    // # Popup
    func popupBodyColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupTextColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupBorderColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupOuterShadowColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupBorderSizeWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> CGFloat
    func popupHighlightedBackgroundColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
    func popupHighlightedTextColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor
}


extension KeyboardTheme {
    public func keyboardBackgroundColorWithAppearanceVariant(_ appearanceVariant: KeyboardAppearanceVariant) -> UIColor {
        return UIColor.clear
    }

    public func popupHighlightedBackgroundColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupTextColorWithAppearanceVariant(appearanceVariant)
    }

    public func popupHighlightedTextColorWithAppearanceVariant(_ appearanceVariant: KeyboardKeyAppearanceVariant) -> UIColor {
        return self.popupBodyColorWithAppearanceVariant(appearanceVariant)
    }

}
