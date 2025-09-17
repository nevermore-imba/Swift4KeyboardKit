//
//  KeyboardKeyLockedShiftSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyLockedShiftSymbolView: KeyboardKeyDrawableSymbolView {
    override public func draw() {
        let color = self.tintColor
        let shiftLockedPath = UIBezierPath()
        shiftLockedPath.move(to: CGPoint(x: -4.25, y: 9.75))
        shiftLockedPath.addLine(to: CGPoint(x: 4.25, y: 9.75))
        shiftLockedPath.addLine(to: CGPoint(x: 4.25, y: 7.25))
        shiftLockedPath.addLine(to: CGPoint(x: -4.25, y: 7.25))
        shiftLockedPath.addLine(to: CGPoint(x: -4.25, y: 9.75))
        shiftLockedPath.close()
        shiftLockedPath.move(to: CGPoint(x: 0, y: -10))
        shiftLockedPath.addLine(to: CGPoint(x: 9.75, y: -0.25))
        shiftLockedPath.addLine(to: CGPoint(x: 4.25, y: -0.25))
        shiftLockedPath.addLine(to: CGPoint(x: 4.25, y: 4.75))
        shiftLockedPath.addLine(to: CGPoint(x: -4.25, y: 4.75))
        shiftLockedPath.addLine(to: CGPoint(x: -4.25, y: -0.25))
        shiftLockedPath.addLine(to: CGPoint(x: -9.75, y: -0.25))
        shiftLockedPath.addLine(to: CGPoint(x: 0, y: -10))
        shiftLockedPath.close()
        shiftLockedPath.lineJoinStyle = .round
        color?.setFill()
        shiftLockedPath.fill()
        color?.setStroke()
        shiftLockedPath.lineWidth = 1.5
        shiftLockedPath.stroke()
    }
}
