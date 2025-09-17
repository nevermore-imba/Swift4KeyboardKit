//
//  KeyboardKeyEmojiSymbolView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/26/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public final class KeyboardKeyEmojiSymbolView: KeyboardKeyDrawableSymbolView {
    public override func draw() {
        let color = self.tintColor

        let emojiPath = UIBezierPath()
        emojiPath.move(to: CGPoint(x: -0.25, y: 9.5))
        emojiPath.addCurve(to: CGPoint(x: 9.5, y: -0.25), controlPoint1: CGPoint(x: 5.13, y: 9.5), controlPoint2: CGPoint(x: 9.5, y: 5.13))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: -10), controlPoint1: CGPoint(x: 9.5, y: -5.63), controlPoint2: CGPoint(x: 5.13, y: -10))
        emojiPath.addCurve(to: CGPoint(x: -10, y: -0.25), controlPoint1: CGPoint(x: -5.63, y: -10), controlPoint2: CGPoint(x: -10, y: -5.63))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 9.5), controlPoint1: CGPoint(x: -10, y: 5.13), controlPoint2: CGPoint(x: -5.63, y: 9.5))
        emojiPath.close()
        emojiPath.move(to: CGPoint(x: -0.25, y: 8.5))
        emojiPath.addCurve(to: CGPoint(x: 8.5, y: -0.25), controlPoint1: CGPoint(x: 4.58, y: 8.5), controlPoint2: CGPoint(x: 8.5, y: 4.58))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: -9), controlPoint1: CGPoint(x: 8.5, y: -5.08), controlPoint2: CGPoint(x: 4.58, y: -9))
        emojiPath.addCurve(to: CGPoint(x: -9, y: -0.25), controlPoint1: CGPoint(x: -5.08, y: -9), controlPoint2: CGPoint(x: -9, y: -5.08))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 8.5), controlPoint1: CGPoint(x: -9, y: 4.58), controlPoint2: CGPoint(x: -5.08, y: 8.5))
        emojiPath.close()
        emojiPath.move(to: CGPoint(x: -3.25, y: -2))
        emojiPath.addCurve(to: CGPoint(x: -2, y: -3.25), controlPoint1: CGPoint(x: -2.56, y: -2), controlPoint2: CGPoint(x: -2, y: -2.56))
        emojiPath.addCurve(to: CGPoint(x: -3.25, y: -4.5), controlPoint1: CGPoint(x: -2, y: -3.94), controlPoint2: CGPoint(x: -2.56, y: -4.5))
        emojiPath.addCurve(to: CGPoint(x: -4.5, y: -3.25), controlPoint1: CGPoint(x: -3.94, y: -4.5), controlPoint2: CGPoint(x: -4.5, y: -3.94))
        emojiPath.addCurve(to: CGPoint(x: -3.25, y: -2), controlPoint1: CGPoint(x: -4.5, y: -2.56), controlPoint2: CGPoint(x: -3.94, y: -2))
        emojiPath.close()
        emojiPath.move(to: CGPoint(x: 2.75, y: -2))
        emojiPath.addCurve(to: CGPoint(x: 4, y: -3.25), controlPoint1: CGPoint(x: 3.44, y: -2), controlPoint2: CGPoint(x: 4, y: -2.56))
        emojiPath.addCurve(to: CGPoint(x: 2.75, y: -4.5), controlPoint1: CGPoint(x: 4, y: -3.94), controlPoint2: CGPoint(x: 3.44, y: -4.5))
        emojiPath.addCurve(to: CGPoint(x: 1.5, y: -3.25), controlPoint1: CGPoint(x: 2.06, y: -4.5), controlPoint2: CGPoint(x: 1.5, y: -3.94))
        emojiPath.addCurve(to: CGPoint(x: 2.75, y: -2), controlPoint1: CGPoint(x: 1.5, y: -2.56), controlPoint2: CGPoint(x: 2.06, y: -2))
        emojiPath.close()
        emojiPath.move(to: CGPoint(x: -7.11, y: 1.16))
        emojiPath.addCurve(to: CGPoint(x: -6.15, y: 0.23), controlPoint1: CGPoint(x: -7.36, y: 0.38), controlPoint2: CGPoint(x: -6.93, y: -0.02))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 1.21), controlPoint1: CGPoint(x: -6.15, y: 0.23), controlPoint2: CGPoint(x: -3.91, y: 1.21))
        emojiPath.addCurve(to: CGPoint(x: 5.65, y: 0.23), controlPoint1: CGPoint(x: 3.41, y: 1.21), controlPoint2: CGPoint(x: 5.65, y: 0.23))
        emojiPath.addCurve(to: CGPoint(x: 6.61, y: 1.18), controlPoint1: CGPoint(x: 6.43, y: -0.03), controlPoint2: CGPoint(x: 6.88, y: 0.4))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 6.58), controlPoint1: CGPoint(x: 6.61, y: 1.18), controlPoint2: CGPoint(x: 5.6, y: 6.58))
        emojiPath.addCurve(to: CGPoint(x: -7.11, y: 1.16), controlPoint1: CGPoint(x: -6.1, y: 6.58), controlPoint2: CGPoint(x: -7.11, y: 1.16))
        emojiPath.close()
        emojiPath.move(to: CGPoint(x: -0.25, y: 2.19))
        emojiPath.addCurve(to: CGPoint(x: -5.15, y: 1.47), controlPoint1: CGPoint(x: -2.93, y: 2.19), controlPoint2: CGPoint(x: -5.15, y: 1.47))
        emojiPath.addCurve(to: CGPoint(x: -5.44, y: 1.96), controlPoint1: CGPoint(x: -5.67, y: 1.33), controlPoint2: CGPoint(x: -5.82, y: 1.57))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 3.65), controlPoint1: CGPoint(x: -5.44, y: 1.96), controlPoint2: CGPoint(x: -4.64, y: 3.65))
        emojiPath.addCurve(to: CGPoint(x: 4.95, y: 1.94), controlPoint1: CGPoint(x: 4.14, y: 3.65), controlPoint2: CGPoint(x: 4.95, y: 1.94))
        emojiPath.addCurve(to: CGPoint(x: 4.64, y: 1.48), controlPoint1: CGPoint(x: 5.31, y: 1.54), controlPoint2: CGPoint(x: 5.17, y: 1.34))
        emojiPath.addCurve(to: CGPoint(x: -0.25, y: 2.19), controlPoint1: CGPoint(x: 4.64, y: 1.48), controlPoint2: CGPoint(x: 2.43, y: 2.19))
        emojiPath.close()
        emojiPath.usesEvenOddFillRule = true

        color?.setFill()
        emojiPath.fill()
    }
}
