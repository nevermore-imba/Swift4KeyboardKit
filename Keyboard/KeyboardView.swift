//
//  KeyboardView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

internal final class KeyboardView: UIView {

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    var touchToView: [UITouch:UIView]

    override init(frame: CGRect) {
        self.touchToView = [:]

        super.init(frame: frame)

        self.contentMode = .redraw
        self.isMultipleTouchEnabled = true
        self.isUserInteractionEnabled = true
        self.isOpaque = false
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override var intrinsicContentSize: CGSize {
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let actualScreenWidth = (UIScreen.main.nativeBounds.size.width / UIScreen.main.nativeScale)
        let canonicalPortraitHeight = (isPad ? CGFloat(264) : CGFloat(interfaceOrientation.isPortrait && actualScreenWidth >= 400 ? 226 : 216))
        let canonicalLandscapeHeight = (isPad ? CGFloat(352) : CGFloat(162))
        let canonicalHeight = interfaceOrientation.isPortrait ? canonicalPortraitHeight : canonicalLandscapeHeight
        return CGSize(width: actualScreenWidth, height: canonicalHeight)
    }

    // Why have this useless drawRect? Well, if we just set the backgroundColor to clearColor,
    // then some weird optimization happens on UIKit's side where tapping down on a transparent pixel will
    // not actually recognize the touch. Having a manual drawRect fixes this behavior, even though it doesn't
    // actually do anything.
    override func draw(_ rect: CGRect) {

    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !self.isHidden && self.alpha > 0 && self.isUserInteractionEnabled else {
            return nil
        }

        return self.bounds.contains(point) ? self : nil
    }

    func handleControl(_ view: UIView?, controlEvent: UIControl.Event, event: UIEvent?) {
        guard let controlView = view as? UIControl else {
            return
        }

        for target in controlView.allTargets {
            guard let actions = controlView.actions(forTarget: target, forControlEvent: controlEvent) else {
                continue
            }
            actions.forEach {
                controlView.sendAction(Selector($0), to: target, for: event)
            }
        }
    }

    func findNearestView(_ position: CGPoint) -> UIView? {
        guard self.bounds.contains(position) else {
            return nil
        }

        var closest: (view: UIView, distance: CGFloat)!

        for view in self.subviews {
            guard !view.isHidden else {
                continue
            }

            let distance = view.frame.distanceTo(point: position)

            if closest == nil || closest.distance > distance {
                closest = (view: view, distance: distance)
            }
        }

        guard closest != nil else {
            return nil
        }

        return closest.view
    }

    func resetTrackedViews() {
        for view in self.touchToView.values {
            self.handleControl(view, controlEvent: .touchCancel, event: nil)
        }

        self.touchToView.removeAll(keepingCapacity: true)
    }

    func ownView(_ newTouch: UITouch, viewToOwn: UIView?) -> Bool {
        var foundView = false

        if viewToOwn != nil {
            for (touch, view) in self.touchToView {
                if viewToOwn == view {
                    if touch == newTouch {
                        break
                    }
                    else {
                        self.touchToView[touch] = nil
                        foundView = true
                    }
                    break
                }
            }
        }

        self.touchToView[newTouch] = viewToOwn
        return foundView
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let view = findNearestView(position)

            let viewChangedOwnership = self.ownView(touch, viewToOwn: view)

            if !viewChangedOwnership {
                self.handleControl(view, controlEvent: .touchDown, event: event)

                if touch.tapCount > 1 {
                    // two events, I think this is the correct behavior but I have not tested with an actual UIControl
                    self.handleControl(view, controlEvent: .touchDownRepeat, event: event)
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)

            let oldView = self.touchToView[touch]
            var newView: UIView?

            if oldView != nil {
                let point = touch.location(in: oldView!)
                let hitView = oldView!.hitTest(point, with: event)

                if hitView != nil {
                    newView = oldView
                }
            }

            newView = newView ?? findNearestView(position)

            if oldView != newView {
                self.handleControl(oldView, controlEvent: .touchDragExit, event: event)

                let viewChangedOwnership = self.ownView(touch, viewToOwn: newView)

                if !viewChangedOwnership {
                    self.handleControl(newView, controlEvent: .touchDragEnter, event: event)
                }
                else {
                    self.handleControl(newView, controlEvent: .touchDragInside, event: event)
                }
            }
            else {
                self.handleControl(oldView, controlEvent: .touchDragInside, event: event)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let view = self.touchToView[touch]

            let touchPosition = touch.location(in: self)

            if self.bounds.contains(touchPosition) {
                self.handleControl(view, controlEvent: .touchUpInside, event: event)
            }
            else {
                self.handleControl(view, controlEvent: .touchCancel, event: event)
            }

            self.touchToView[touch] = nil
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if let touches = touches {
            for touch in touches {
                let view = self.touchToView[touch]
                self.handleControl(view, controlEvent: .touchCancel, event: event)
                self.touchToView[touch] = nil
            }
        }
    }

}
