//
//  KeyboardKeyEventTarget.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/14/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal class KeyboardKeyEventTarget: NSObject {
    
    private unowned var listenerCoordinator: KeyboardKeyListenerCoordinator

    internal init(listenerCoordinator: KeyboardKeyListenerCoordinator) {
        self.listenerCoordinator = listenerCoordinator
    }

    internal func registerKeyView(_ keyView: KeyboardKeyView) {
        // Reasons: http://stackoverflow.com/questions/6131549/how-can-i-determine-which-uicontrolevents-type-caused-a-uievent
        keyView.addTarget(self, action: #selector(keyViewDidTouchDown(_:event:)), for: .touchDown)
        keyView.addTarget(self, action: #selector(keyViewDidTouchDownRepeat(_:event:)), for: .touchDownRepeat)
        keyView.addTarget(self, action: #selector(keyViewDidTouchDragInside(_:event:)), for: .touchDragInside)
        keyView.addTarget(self, action: #selector(keyViewDidTouchDragOutside(_:event:)), for: .touchDragOutside)
        keyView.addTarget(self, action: #selector(keyViewDidTouchDragEnter(_:event:)), for: .touchDragEnter)
        keyView.addTarget(self, action: #selector(keyViewDidTouchDragExit(_:event:)), for: .touchDragExit)
        keyView.addTarget(self, action: #selector(keyViewDidTouchUpInside(_:event:)), for: .touchUpInside)
        keyView.addTarget(self, action: #selector(keyViewDidTouchUpOutside(_:event:)), for: .touchUpOutside)
        keyView.addTarget(self, action: #selector(keyViewDidTouchCancel(_:event:)), for: .touchCancel)
    }

    internal func unregisterKeyView(_ keyView: KeyboardKeyView) {
        keyView.removeTarget(self, action: nil, for: .allEvents)
    }

    internal func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, event: UIEvent) {
        self.listenerCoordinator.keyViewDidSendControlEvents(
            controlEvents,
            keyView: keyView,
            event: event
        )
    }

    // # keyViewDidTouch*'s
    @objc internal func keyViewDidTouchDown(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDown, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchDownRepeat(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDownRepeat, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchDragInside(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDragInside, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchDragOutside(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDragOutside, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchDragEnter(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDragEnter, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchDragExit(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchDragExit, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchUpInside(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchUpInside, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchUpOutside(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchUpOutside, keyView: keyView, event: event)
    }

    @objc internal func keyViewDidTouchCancel(_ keyView: KeyboardKeyView, event: UIEvent) {
        self.keyViewDidSendEvents(.touchCancel, keyView: keyView, event: event)
    }

}
