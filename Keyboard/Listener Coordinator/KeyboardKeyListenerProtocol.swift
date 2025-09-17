//
//  KeyboardKeyListenerProtocol.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/17/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private var waitTimerToken: Int = 0
private let longWaitTimerInterval: TimeInterval = 0.2
private let veryLongwaitTimerInterval: TimeInterval = 1.5


extension UIControl.Event {
    public static var TouchDownLong = Self(rawValue: 0x04000000)
    public static var TouchDownVeryLong = Self(rawValue: 0x08000000)
}


public protocol KeyboardKeyListenerProtocol: AnyObject {
    func keyViewDidSendEvent(_ event: KeyboardKeyEvent)
    // Temporary!
    func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode)
}


extension Equatable where Self: KeyboardKeyListenerProtocol {
}

public func == (lhs: KeyboardKeyListenerProtocol, rhs: KeyboardKeyListenerProtocol) -> Bool {
    return lhs === rhs
}

extension KeyboardKeyListenerProtocol {

    // Temporary!
    public func keyViewDidSendEvent(_ event: KeyboardKeyEvent) {
        self.keyViewDidSendEvents(
            event.controlEvents,
            keyView: event.keyView,
            key: event.key,
            keyboardMode: event.keyboardMode
        )
    }

    public func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {}

    // # Long Tap
    private var waitTimerCounter: Int {
        get {
            return objc_getAssociatedObject(self, &waitTimerToken) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &waitTimerToken, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    private func invalidateWaitTimer() {
        self.waitTimerCounter += 1
    }

    public func waitForLongTapEvent(event: KeyboardKeyEvent) {
        let controlEvents = event.controlEvents

        if [.touchDown].contains(controlEvents) {
            self.invalidateWaitTimer()

            let capturedWaitTimerCounter = waitTimerCounter
            let capturedEvent = event

            DispatchQueue.main.asyncAfter(deadline: .now() + longWaitTimerInterval) { [weak self] in
                guard capturedWaitTimerCounter == self?.waitTimerCounter else {
                    return
                }

                self?.keyViewDidSendEvent(
                    KeyboardKeyEvent(
                        controlEvents: .TouchDownLong,//capturedEvent.controlEvents.union(.TouchDownLong),
                        event: capturedEvent.event,
                        key: capturedEvent.key,
                        keyView: capturedEvent.keyView,
                        keyboardMode: capturedEvent.keyboardMode,
                        keyboardViewController: capturedEvent.keyboardViewController
                    )
                )
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + veryLongwaitTimerInterval) { [weak self] in
                guard capturedWaitTimerCounter == self?.waitTimerCounter else {
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    self?.keyViewDidSendEvent(
                        KeyboardKeyEvent(
                            controlEvents: .TouchDownVeryLong, //capturedEvent.controlEvents.union(.TouchDownVeryLong),
                            event: capturedEvent.event,
                            key: capturedEvent.key,
                            keyView: capturedEvent.keyView,
                            keyboardMode: capturedEvent.keyboardMode,
                            keyboardViewController: capturedEvent.keyboardViewController
                        )
                    )
                }
            }
        }
        else if [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside, .touchDragOutside].contains(controlEvents) {
            self.invalidateWaitTimer()
        }
    }
}
