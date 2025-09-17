//
//  KeyboardKeyMode.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public struct KeyboardKeyMode {

    public var popupMode: KeyboardKeyPopupTypeMode = .None
    public var activityMode: KeyboardKeyActivityMode = .Enabled
    public var highlightMode: KeyboardKeyHighlightMode = .None
    public var selectionMode: KeyboardKeySelectionMode = .None

    public var compoundModificationMode: KeyboardKeyCompoundModificationMode {
        if self.activityMode == .Disabled {
            return .Disabled
        }

        if self.highlightMode == .Highlighted {
            return .Highlighted
        }

        if self.selectionMode == .Selected {
            return .Selected
        }

        return .Normal
    }
}


extension KeyboardKeyMode: Equatable {}
extension KeyboardKeyMode: Hashable {}
