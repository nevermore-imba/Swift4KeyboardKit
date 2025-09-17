//
//  KeyboardKeyContentView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/4/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardKeyContentView: UIView {

    public var appearance: KeyboardKeyAppearance = KeyboardKeyAppearance()
}


extension KeyboardKeyContentView: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        fatalError("copyWithZone(zone:) has not been implemented")
    }
}
