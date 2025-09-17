//
//  KeyboardContentView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public class KeyboardContentView: UIView {

    public override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    public override var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        //intrinsicContentSize.width = self.superview!.frame.size.width
        return intrinsicContentSize
    }

}
