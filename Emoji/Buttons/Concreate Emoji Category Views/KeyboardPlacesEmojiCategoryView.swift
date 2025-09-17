//
//  KeyboardPlacesEmojiCategoryView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/31/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


public final class KeyboardPlacesEmojiCategoryView: KeyboardEmojiCategoryView {

    public override var emojiCategory: KeyboardEmojiCategory {
        return .Places
    }

    internal override func draw() {
        super.draw()

        let color = self.tintColor

        let placesBuildingPath = UIBezierPath()
        placesBuildingPath.move(to: CGPointMake(2.48, -4))
        placesBuildingPath.addLine(to: CGPointMake(2.48, -8))
        placesBuildingPath.addLine(to: CGPointMake(-4.51, -8))
        placesBuildingPath.addLine(to: CGPointMake(-4.51, -2))
        placesBuildingPath.addLine(to: CGPointMake(-8, -2))
        placesBuildingPath.addLine(to: CGPointMake(-8, 7))
        placesBuildingPath.addLine(to: CGPointMake(-7, 7))
        placesBuildingPath.addLine(to: CGPointMake(-7, -1))
        placesBuildingPath.addLine(to: CGPointMake(-3.51, -1))
        placesBuildingPath.addLine(to: CGPointMake(-3.51, -7))
        placesBuildingPath.addLine(to: CGPointMake(1.48, -7))
        placesBuildingPath.addLine(to: CGPointMake(1.48, -2))
        placesBuildingPath.addLine(to: CGPointMake(2.48, -2))
        placesBuildingPath.addLine(to: CGPointMake(2.48, -3))
        placesBuildingPath.addLine(to: CGPointMake(7, -3))
        placesBuildingPath.addLine(to: CGPointMake(7, 7))
        placesBuildingPath.addLine(to: CGPointMake(8, 7))
        placesBuildingPath.addLine(to: CGPointMake(8, -4))
        placesBuildingPath.addLine(to: CGPointMake(2.48, -4))
        placesBuildingPath.close()
        placesBuildingPath.usesEvenOddFillRule = true
        color?.setFill()
        placesBuildingPath.fill()

        let rectanglePath = UIBezierPath(rect: CGRectMake(-6, 0, 1, 1))
        color?.setFill()
        rectanglePath.fill()

        let rectangle2Path = UIBezierPath(rect: CGRectMake(-2.5, -6, 1, 1))
        color?.setFill()
        rectangle2Path.fill()

        let rectangle3Path = UIBezierPath(rect: CGRectMake(-2.5, -4, 1, 1))
        color?.setFill()
        rectangle3Path.fill()

        let rectangle4Path = UIBezierPath(rect: CGRectMake(-0.5, -6, 1, 1))
        color?.setFill()
        rectangle4Path.fill()

        let rectangle5Path = UIBezierPath(rect: CGRectMake(-0.5, -4, 1, 1))
        color?.setFill()
        rectangle5Path.fill()

        let rectangle6Path = UIBezierPath(rect: CGRectMake(5, -2, 1, 1))
        color?.setFill()
        rectangle6Path.fill()

        let rectangle7Path = UIBezierPath(rect: CGRectMake(5, 0, 1, 1))
        color?.setFill()
        rectangle7Path.fill()

        let placesCarPath = UIBezierPath()
        placesCarPath.move(to: CGPointMake(4.98, 6))
        placesCarPath.addLine(to: CGPointMake(2.48, 6))
        placesCarPath.addLine(to: CGPointMake(1.98, 6))
        placesCarPath.addLine(to: CGPointMake(-2.01, 6))
        placesCarPath.addLine(to: CGPointMake(-2.51, 6))
        placesCarPath.addLine(to: CGPointMake(-5.01, 6))
        placesCarPath.addLine(to: CGPointMake(-5.01, 5.68))
        placesCarPath.addCurve(to: CGPointMake(-4.83, 5.5), controlPoint1: CGPointMake(-5.01, 5.58), controlPoint2: CGPointMake(-4.93, 5.5))
        placesCarPath.addLine(to: CGPointMake(-2.51, 5.5))
        placesCarPath.addCurve(to: CGPointMake(-2.01, 5), controlPoint1: CGPointMake(-2.51, 5.22), controlPoint2: CGPointMake(-2.29, 5))
        placesCarPath.addLine(to: CGPointMake(1.98, 5))
        placesCarPath.addCurve(to: CGPointMake(2.48, 5.5), controlPoint1: CGPointMake(2.26, 5), controlPoint2: CGPointMake(2.48, 5.22))
        placesCarPath.addLine(to: CGPointMake(4.8, 5.5))
        placesCarPath.addCurve(to: CGPointMake(4.98, 5.68), controlPoint1: CGPointMake(4.9, 5.5), controlPoint2: CGPointMake(4.98, 5.58))
        placesCarPath.addLine(to: CGPointMake(4.98, 6))
        placesCarPath.close()
        placesCarPath.move(to: CGPointMake(-3.76, 3.38))
        placesCarPath.addCurve(to: CGPointMake(-2.88, 4.25), controlPoint1: CGPointMake(-3.28, 3.38), controlPoint2: CGPointMake(-2.88, 3.77))
        placesCarPath.addCurve(to: CGPointMake(-3.76, 5.12), controlPoint1: CGPointMake(-2.88, 4.73), controlPoint2: CGPointMake(-3.28, 5.12))
        placesCarPath.addCurve(to: CGPointMake(-4.63, 4.25), controlPoint1: CGPointMake(-4.24, 5.12), controlPoint2: CGPointMake(-4.63, 4.73))
        placesCarPath.addCurve(to: CGPointMake(-3.76, 3.38), controlPoint1: CGPointMake(-4.63, 3.77), controlPoint2: CGPointMake(-4.24, 3.38))
        placesCarPath.addLine(to: CGPointMake(-3.76, 3.38))
        placesCarPath.close()
        placesCarPath.move(to: CGPointMake(-3.07, 2))
        placesCarPath.addCurve(to: CGPointMake(-0.51, -0.56), controlPoint1: CGPointMake(-3.07, 0.59), controlPoint2: CGPointMake(-1.92, -0.56))
        placesCarPath.addLine(to: CGPointMake(0.48, -0.56))
        placesCarPath.addCurve(to: CGPointMake(3.04, 2), controlPoint1: CGPointMake(1.89, -0.56), controlPoint2: CGPointMake(3.04, 0.59))
        placesCarPath.addLine(to: CGPointMake(3.04, 2.5))
        placesCarPath.addLine(to: CGPointMake(-3.07, 2.5))
        placesCarPath.addLine(to: CGPointMake(-3.07, 2))
        placesCarPath.close()
        placesCarPath.move(to: CGPointMake(3.73, 3.38))
        placesCarPath.addCurve(to: CGPointMake(4.6, 4.25), controlPoint1: CGPointMake(4.21, 3.38), controlPoint2: CGPointMake(4.6, 3.77))
        placesCarPath.addCurve(to: CGPointMake(3.73, 5.12), controlPoint1: CGPointMake(4.6, 4.73), controlPoint2: CGPointMake(4.21, 5.12))
        placesCarPath.addCurve(to: CGPointMake(2.85, 4.25), controlPoint1: CGPointMake(3.25, 5.12), controlPoint2: CGPointMake(2.85, 4.73))
        placesCarPath.addCurve(to: CGPointMake(3.73, 3.38), controlPoint1: CGPointMake(2.85, 3.77), controlPoint2: CGPointMake(3.25, 3.38))
        placesCarPath.addLine(to: CGPointMake(3.73, 3.38))
        placesCarPath.close()
        placesCarPath.move(to: CGPointMake(4.1, 2.5))
        placesCarPath.addLine(to: CGPointMake(3.98, 2.5))
        placesCarPath.addLine(to: CGPointMake(3.98, 2))
        placesCarPath.addCurve(to: CGPointMake(0.48, -1.5), controlPoint1: CGPointMake(3.98, 0.07), controlPoint2: CGPointMake(2.41, -1.5))
        placesCarPath.addLine(to: CGPointMake(-0.51, -1.5))
        placesCarPath.addCurve(to: CGPointMake(-4.01, 2), controlPoint1: CGPointMake(-2.44, -1.5), controlPoint2: CGPointMake(-4.01, 0.07))
        placesCarPath.addLine(to: CGPointMake(-4.01, 2.5))
        placesCarPath.addLine(to: CGPointMake(-4.13, 2.5))
        placesCarPath.addCurve(to: CGPointMake(-5.5, 3.88), controlPoint1: CGPointMake(-4.89, 2.5), controlPoint2: CGPointMake(-5.5, 3.12))
        placesCarPath.addLine(to: CGPointMake(-5.5, 6))
        placesCarPath.addCurve(to: CGPointMake(-5.01, 6.5), controlPoint1: CGPointMake(-5.5, 6.28), controlPoint2: CGPointMake(-5.28, 6.5))
        placesCarPath.addLine(to: CGPointMake(-5.01, 7.62))
        placesCarPath.addCurve(to: CGPointMake(-4.63, 8), controlPoint1: CGPointMake(-5.01, 7.83), controlPoint2: CGPointMake(-4.84, 8))
        placesCarPath.addLine(to: CGPointMake(-3.38, 8))
        placesCarPath.addCurve(to: CGPointMake(-3.01, 7.62), controlPoint1: CGPointMake(-3.18, 8), controlPoint2: CGPointMake(-3.01, 7.83))
        placesCarPath.addLine(to: CGPointMake(-3.01, 6.5))
        placesCarPath.addLine(to: CGPointMake(2.98, 6.5))
        placesCarPath.addLine(to: CGPointMake(2.98, 7.62))
        placesCarPath.addCurve(to: CGPointMake(3.35, 8), controlPoint1: CGPointMake(2.98, 7.83), controlPoint2: CGPointMake(3.15, 8))
        placesCarPath.addLine(to: CGPointMake(4.6, 8))
        placesCarPath.addCurve(to: CGPointMake(4.98, 7.62), controlPoint1: CGPointMake(4.81, 8), controlPoint2: CGPointMake(4.98, 7.83))
        placesCarPath.addLine(to: CGPointMake(4.98, 6.5))
        placesCarPath.addCurve(to: CGPointMake(5.47, 6), controlPoint1: CGPointMake(5.25, 6.5), controlPoint2: CGPointMake(5.47, 6.28))
        placesCarPath.addLine(to: CGPointMake(5.47, 3.88))
        placesCarPath.addCurve(to: CGPointMake(4.1, 2.5), controlPoint1: CGPointMake(5.47, 3.12), controlPoint2: CGPointMake(4.86, 2.5))
        placesCarPath.addLine(to: CGPointMake(4.1, 2.5))
        placesCarPath.close()
        placesCarPath.usesEvenOddFillRule = true
        color?.setFill()
        placesCarPath.fill()
    }

}
