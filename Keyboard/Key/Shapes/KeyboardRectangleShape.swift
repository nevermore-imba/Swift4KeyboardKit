//
//  KeyboardRectangleShape.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

typealias KeyboardShapeSegmentPoints = (begin: CGPoint, end: CGPoint)
private let four: Int = 4
private let fourRange = 0..<four
private let fourZeroFloats: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
private let fourZeroPoints = [CGPointZero, CGPointZero, CGPointZero, CGPointZero]
private let emptySegmentPoints: KeyboardShapeSegmentPoints = (begin: CGPointZero, end: CGPointZero)
private let fourZeroSegmentPoints: [KeyboardShapeSegmentPoints] = [emptySegmentPoints, emptySegmentPoints, emptySegmentPoints, emptySegmentPoints]

internal class KeyboardRectangleShape: KeyboardShape {

    private var startingPoints: [CGPoint] = fourZeroPoints
    private var segmentPoints: [KeyboardShapeSegmentPoints] = [emptySegmentPoints, emptySegmentPoints, emptySegmentPoints, emptySegmentPoints]
    private var arcCenters: [CGPoint] = fourZeroPoints
    private var arcStartingAngles: [CGFloat] = fourZeroFloats

    internal var attachmentDirection: KeyboardDirection? = nil {
        didSet {
            if oldValue != self.attachmentDirection {
                self.needRecreatePaths = true
            }
        }
    }

    internal override func createPaths() {
        super.createPaths()

        assert(self.hasUnderPath || (self.underOffset != CGPointZero), "If the Shape do not have a `underPath`, it must have zero `underOffset`.")

        let origin = self.bounds.origin
        let segmentSize = self.bounds.size - self.underOffset

        // base, untranslated corner points
        self.startingPoints[0] = origin + CGPoint(x: 0, y: segmentSize.height)
        self.startingPoints[1] = origin + CGPoint(x: 0, y: 0)
        self.startingPoints[2] = origin + CGPoint(x: segmentSize.width, y: 0)
        self.startingPoints[3] = origin + CGPoint(x: segmentSize.width, y: segmentSize.height)

        self.arcStartingAngles[0] = .pi / 2
        self.arcStartingAngles[2] = -.pi / 2
        self.arcStartingAngles[1] = .pi
        self.arcStartingAngles[3] = 0

        for i in fourRange {
            var offset = CGPoint()

            switch i {
            case 0: offset.y = -cornerRadius; break
            case 1: offset.x = +cornerRadius; break
            case 2: offset.y = +cornerRadius; break
            case 3: offset.x = -cornerRadius; break
            default: break
            }

            let currentPoint = self.startingPoints[i]
            let nextPoint = self.startingPoints[(i + 1) % four]

            let startPoint = currentPoint + self.underOffset + offset
            let endPoint = nextPoint + self.underOffset - offset

            self.segmentPoints[i] = (startPoint, endPoint)

            self.arcCenters[i] = startPoint + CGPoint(x: -offset.y, y: offset.x)
        }

        // order of edge drawing: left edge, down edge, right edge, up edge

        // We need to have separate paths for all the edges so we can toggle them as needed.
        // Unfortunately, it doesn't seem possible to assemble the connected fill path
        // by simply using CGPathAddPath, since it closes all the subpaths, so we have to
        // duplicate the code a little bit.

        let fillPath = UIBezierPath()
        var edgePaths: [UIBezierPath] = []
        var prevPoint: CGPoint?

        let direction = self.attachmentDirection

        for i in fourRange {

            var edgePath: UIBezierPath? = nil
            let segmentPoint = self.segmentPoints[i]



            if direction != nil && (direction!.rawValue == i) {
                // do nothing
                continue
            }
            else {
                edgePath = UIBezierPath()

                // TODO: figure out if this is ncessary
                if prevPoint == nil {
                    prevPoint = segmentPoint.0
                    fillPath.move(to: prevPoint!)
                }

                fillPath.addLine(to: segmentPoint.0)
                fillPath.addLine(to: segmentPoint.1)

                edgePath!.move(to: segmentPoint.0)
                edgePath!.addLine(to: segmentPoint.1)

                prevPoint = segmentPoint.1
            }

            if direction != nil && (direction!.rawValue == ((i + 1) % 4)) {
                // do nothing
            }
            else {
                edgePath = edgePath ?? UIBezierPath()

                if prevPoint == nil {
                    prevPoint = segmentPoint.1
                    fillPath.move(to: prevPoint!)
                }

                let startAngle = self.arcStartingAngles[(i + 1) % 4]
                let endAngle = startAngle + .pi / 2
                let arcCenter = self.arcCenters[(i + 1) % 4]

                fillPath.addLine(to: prevPoint!)
                fillPath.addArc(withCenter: arcCenter, radius: self.cornerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

                edgePath!.move(to: prevPoint!)
                edgePath!.addArc(withCenter: arcCenter, radius: self.cornerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

                prevPoint = self.segmentPoints[(i + 1) % 4].0
            }


            if let edgePath = edgePath {
                edgePath.apply(CGAffineTransformMakeTranslation(-self.underOffset.x, -self.underOffset.y))
                edgePaths.append(edgePath)
            }
        }

        fillPath.close()
        fillPath.apply(CGAffineTransformMakeTranslation(-self.underOffset.x, -self.underOffset.y))

        if self.hasUnderPath {
            let underPath = UIBezierPath()

            underPath.move(to: self.segmentPoints[2].1)

            var startAngle = self.arcStartingAngles[3]
            var endAngle = startAngle + CGFloat(.pi/2.0)
            underPath.addArc(withCenter: self.arcCenters[3], radius: CGFloat(self.cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: true)

            underPath.addLine(to: self.segmentPoints[3].1)

            startAngle = self.arcStartingAngles[0]
            endAngle = startAngle + CGFloat(.pi/2.0)
            underPath.addArc(withCenter: self.arcCenters[0], radius: CGFloat(self.cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: true)

            underPath.addLine(to: self.segmentPoints[0].0 - self.underOffset)

            startAngle = self.arcStartingAngles[1]
            endAngle = startAngle - CGFloat(.pi/2.0)
            underPath.addArc(withCenter: self.arcCenters[0] - self.underOffset, radius: CGFloat(self.cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: false)

            underPath.addLine(to: CGPoint(x: self.segmentPoints[2].1.x - self.cornerRadius, y: self.segmentPoints[2].1.y + self.cornerRadius) - self.underOffset)

            startAngle = self.arcStartingAngles[0]
            endAngle = startAngle - CGFloat(.pi/2.0)
            underPath.addArc(withCenter: self.arcCenters[3] - self.underOffset, radius: CGFloat(self.cornerRadius), startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            underPath.close()
            
            self.underPath = underPath
        }

        let compoundEdgePath = UIBezierPath()

        for edgePath in edgePaths {
            compoundEdgePath.append(edgePath)
        }

        self.fillPath = fillPath
        self.edgePaths = edgePaths
        self.edgePath = compoundEdgePath
    }

    internal func attachmentPoints() -> (CGPoint, CGPoint) {
        let direction = self.attachmentDirection!

        let returnValue = (
            self.segmentPoints[direction.clockwise().rawValue].0,
            self.segmentPoints[direction.counterclockwise().rawValue].1)

        return returnValue
    }
}



func fixIntersection(_ first: KeyboardRectangleShape, second: KeyboardRectangleShape) {
    var firstRect = first.bounds
    var secondRect = second.bounds

    if !CGRectIntersectsRect(firstRect, secondRect) {
        return
    }

    let intersection = CGRectIntersection(firstRect, secondRect)

    let amount = intersection.height + 8.0
    let ratio = CGFloat(1)

    (_, firstRect) = firstRect.divided(atDistance: (amount * ratio).rounded(), from: .minYEdge)
    (_, secondRect) = secondRect.divided(atDistance: (amount * (1 - ratio)).rounded(), from: .maxYEdge)

    first.bounds = firstRect
    second.bounds = secondRect
}
