//
//  KeyboardKeyDisabledShiftSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyDisabledShiftSymbolView: KeyboardKeyDrawableSymbolView {
    override public func draw() {
        let color = self.tintColor
        let shiftDisabledPath = UIBezierPath()
        shiftDisabledPath.move(to: CGPoint(x: 0, y: -9))
        shiftDisabledPath.addLine(to: CGPoint(x: 9.75, y: 0.75))
        shiftDisabledPath.addLine(to: CGPoint(x: 4.25, y: 0.75))
        shiftDisabledPath.addLine(to: CGPoint(x: 4.25, y: 6.75))
        shiftDisabledPath.addLine(to: CGPoint(x: -4.25, y: 6.75))
        shiftDisabledPath.addLine(to: CGPoint(x: -4.25, y: 0.75))
        shiftDisabledPath.addLine(to: CGPoint(x: -9.75, y: 0.75))
        shiftDisabledPath.addLine(to: CGPoint(x: 0, y: -9))
        shiftDisabledPath.close()
        shiftDisabledPath.lineJoinStyle = .bevel
        color?.setStroke()
        shiftDisabledPath.lineWidth = 1.5
        shiftDisabledPath.stroke()
    }
}
