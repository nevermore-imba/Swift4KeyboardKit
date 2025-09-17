//
//  KeyboardDrawableView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/1/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public  class KeyboardDrawableView: UIControl {
    
    public class var size: CGSize {
        return CGSize(width: 32.0, height: 32.0)
    }

    public override var intrinsicContentSize: CGSize {
        return type(of: self).size
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return type(of: self).size
    }

    public override var tintColor: UIColor! {
        didSet {
            self.setNeedsDisplay()
        }
    }

    public override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else {
            super.draw(rect)
            return
        }

        context.saveGState()

        let xOffset = self.bounds.width / CGFloat(2)
        let yOffset = self.bounds.height / CGFloat(2)

        context.translateBy(x: xOffset, y: yOffset)

        self.draw()

        context.restoreGState()
    }
    
    internal func draw() {
    }
    
}
