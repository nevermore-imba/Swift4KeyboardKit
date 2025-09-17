//
//  KeyboardKeyEnabledShiftSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/20/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardKeyEnabledShiftSymbolView: KeyboardKeyDrawableSymbolView {
    override public func draw() {
        let color = self.tintColor
        let shiftEnabledPath = UIBezierPath()
        shiftEnabledPath.move(to: CGPoint(x: 0, y: -10))
        shiftEnabledPath.addLine(to: CGPoint(x: 9.75, y: -0.25))
        shiftEnabledPath.addLine(to: CGPoint(x: 4.25, y: -0.25))
        shiftEnabledPath.addLine(to: CGPoint(x: 4.25, y: 7.75))
        shiftEnabledPath.addLine(to: CGPoint(x: -4.25, y: 7.75))
        shiftEnabledPath.addLine(to: CGPoint(x: -4.25, y: -0.25))
        shiftEnabledPath.addLine(to: CGPoint(x: -9.75, y: -0.25))
        shiftEnabledPath.addLine(to: CGPoint(x: 0, y: -10))
        shiftEnabledPath.close()
        shiftEnabledPath.lineJoinStyle = .bevel
        color?.setFill()
        shiftEnabledPath.fill()
        color?.setStroke()
        shiftEnabledPath.lineWidth = 1.5
        shiftEnabledPath.stroke()
    }
}
