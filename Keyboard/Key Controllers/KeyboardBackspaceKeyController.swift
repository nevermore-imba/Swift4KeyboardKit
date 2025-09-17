//
//  KeyboardBackspaceKeyController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let backspaceDelay = TimeInterval(0.5)
private let backspaceRepeat = TimeInterval(0.07)


public final class KeyboardBackspaceKeyController: KeyboardKeyListenerProtocol {

    private var delayTimer: Timer?
    private var repeatTimer: Timer?

    public func keyViewDidSendEvents(controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        guard key.type == .Backspace else {
            return
        }

        if [.touchDown].contains(controlEvents) {
            self.keyDownHandler()
        } else if [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside, .touchDragOutside].contains(controlEvents) {
            self.keyUpHandler()
        }
    }

    private func deleteBackward() {
        UIInputViewController.optionalRootInputViewController?.textDocumentProxy.deleteBackward()
    }

    private func keyDownHandler() {
        self.deleteBackward()

        self.cancelTimers()
        self.delayTimer = Timer.scheduledTimer(
            timeInterval: backspaceDelay - backspaceRepeat,
            target: self,
            selector: #selector(delayHandler),
            userInfo: nil,
            repeats: false
        )
    }

    private func keyUpHandler() {
        self.cancelTimers()
    }

    private func cancelTimers() {
        self.delayTimer?.invalidate()
        self.delayTimer = nil
        self.repeatTimer?.invalidate()
        self.repeatTimer = nil
    }

    @objc internal func delayHandler() {
        self.cancelTimers()

        self.repeatTimer = Timer.scheduledTimer(
            timeInterval: backspaceRepeat,
            target: self,
            selector: #selector(repeatHandler),
            userInfo: nil,
            repeats: true
        )
    }

    @objc internal func repeatHandler() {
        self.deleteBackward()
        KeyboardSoundService.sharedInstance.playInputSound()
    }

}
