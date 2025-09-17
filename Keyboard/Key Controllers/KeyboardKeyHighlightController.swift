//
//  KeyboardKeyHighlightController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/24/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardKeyHighlightController: KeyboardKeyListenerProtocol {

    let highlightOnEvents: UIControl.Event = [.touchDown, .touchDragInside, .touchDragEnter]
    let highlightOffEvents: UIControl.Event = [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside, .touchDragOutside]

    internal func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        let appearance = keyView.appearance

        guard appearance.shouldHighlight else {
            return
        }

        if !controlEvents.intersection(highlightOnEvents).isEmpty {
            keyView.keyMode.highlightMode = .Highlighted
            keyView.updateIfNeeded()
            return
        }

        if !controlEvents.intersection(highlightOffEvents).isEmpty {
            keyView.keyMode.highlightMode = .None
            keyView.updateIfNeeded()
            return
        }
    }
    
}
