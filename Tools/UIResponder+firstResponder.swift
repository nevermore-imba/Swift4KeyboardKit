//
//  UIResponder+firstResponder.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

private weak var currentFirstResponder: UIResponder?

extension UIResponder {

    static func firstResponder() -> UIResponder {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(self.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return currentFirstResponder!
    }

    @objc internal func findFirstResponder(_ sender: AnyObject) {
        currentFirstResponder = self
    }

}
