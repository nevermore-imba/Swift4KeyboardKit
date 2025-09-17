//
//  KeyboardKeyDrawableSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public class KeyboardKeyDrawableSymbolView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }

    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func draw() {
        fatalError("")
    }
}
