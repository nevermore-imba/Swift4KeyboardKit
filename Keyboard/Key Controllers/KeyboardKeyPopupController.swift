//
//  KeyboardKeyPopupTypeController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardKeyPopupTypeController: KeyboardKeyListenerProtocol {
    let popupShowEvents: UIControl.Event = [.touchDown, .touchDragInside, .touchDragEnter]
    let popupHideEvents: UIControl.Event = [.touchDragExit, .touchCancel]
    let popupDelayedHideEvents: UIControl.Event = [.touchUpInside, .touchUpOutside, .touchDragOutside]

    internal init() {
    }

    internal func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        let appearance = keyView.appearance

        if key.alternateKeys != nil {
            if popupShowEvents.contains(controlEvents) {
                self.setTimeout(token: keyView.hashValue) {

                    KeyboardSoundService.sharedInstance.playAlternateInputSound()

                    keyView.keyMode.popupMode = .AlternateKeys
                    keyView.updateIfNeeded()
                }
            }
        }

        if popupHideEvents.contains(controlEvents) || popupDelayedHideEvents.contains(controlEvents) {
            self.clearTimeout()
        }

        if
            appearance.shouldShowPreviewPopup &&
            keyView.keyMode.popupMode == .None &&
            popupShowEvents.contains(controlEvents)
        {
            self.showPopupForKeyView(keyView)
            return
        }

        if
            keyView.keyMode.popupMode != .None &&
            popupHideEvents.contains(controlEvents)
        {
            self.hidePopupForKeyView(keyView)
            return
        }

        if
            keyView.keyMode.popupMode != .None &&
            popupDelayedHideEvents.contains(controlEvents)
        {
            let delay = 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.hidePopupForKeyView(keyView)
            }
            return
        }

    }

    private func showPopupForKeyView(_ keyView: KeyboardKeyView) {
        keyView.keyMode.popupMode = .Preview
        keyView.updateIfNeeded()
    }

    private func hidePopupForKeyView(_ keyView: KeyboardKeyView) {
        keyView.keyMode.popupMode = .None
        keyView.updateIfNeeded()
    }

    private var timeoutToken: Int?
    func setTimeout(token: Int?, callback: @escaping () -> Void) {
        guard token != self.timeoutToken else {
            return
        }

        self.clearTimeout()

        self.timeoutToken = token

        let timeoutToken = token

        let delay = 0.7

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak weakSelf = self] in
            guard let strongSelf = weakSelf else {
                return
            }

            guard strongSelf.timeoutToken == timeoutToken else {
                return
            }

            callback()
        }
    }

    func clearTimeout() {
        self.timeoutToken = nil
    }
}



extension UIControl.Event {
    internal static let LongPress = Self(rawValue: 0x01000000)
    internal static let VeryLongPress = Self(rawValue: 0x02000000)
}


extension KeyboardKeyListenerProtocol {

    internal func handleLongPresses(controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {

    }
}
