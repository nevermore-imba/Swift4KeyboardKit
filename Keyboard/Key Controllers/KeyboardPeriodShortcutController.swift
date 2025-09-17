//
//  KeyboardPeriodShortcutController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


private let timeIntervalBetweenSpacesThreshold = 0.7

internal class KeyboardPeriodShortcutController: KeyboardKeyListenerProtocol {
    var numberConsequencesSpaces: Int = 0
    var lastSpacePressedTime: TimeInterval?

    static let sentenceEndingSet: CharacterSet = {
        var characterSet = CharacterSet.letters
        characterSet.insert(charactersIn: "\"'`?!.%])}>")
        return characterSet
    } ()

    internal func keyViewDidSendEvents(_ controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        var shouldInsertPeriod = false

        if controlEvents.contains(.touchUpInside) {
            let now = NSDate().timeIntervalSince1970

            if key.type == .Space {
                if let lastSpacePressedTime = self.lastSpacePressedTime {
                    shouldInsertPeriod = now - lastSpacePressedTime < timeIntervalBetweenSpacesThreshold
                }

                self.lastSpacePressedTime = now
            }
            else {
                self.lastSpacePressedTime = nil
            }
        }

        if shouldInsertPeriod {
            let textDocumentProxy = UIInputViewController.rootInputViewController.textDocumentProxy

            let documentContextBeforeInput = textDocumentProxy.documentContextBeforeInput ?? ""

            guard documentContextBeforeInput.count >= 3 else {
                return
            }

            let startIndex = documentContextBeforeInput.index(documentContextBeforeInput.endIndex, offsetBy: -2)
            let lastTwoCharacters = documentContextBeforeInput[startIndex...]

            guard lastTwoCharacters == "  " else {
                return
            }

            let start = documentContextBeforeInput.index(documentContextBeforeInput.endIndex, offsetBy: -3)
            let end = documentContextBeforeInput.index(documentContextBeforeInput.endIndex, offsetBy: -2)
            let characterBeforeLastTwoCharacters = documentContextBeforeInput[start..<end]

            // It works like: `guard sentenceEndingSet.characterIsMember(characterBeforeLastTwoCharacters) else {}`.
            // More info: http://stackoverflow.com/questions/27697508/nscharacterset-characterismember-with-swifts-character-type
            guard type(of: self).sentenceEndingSet.characterIsMember(characterBeforeLastTwoCharacters.utf16.first!) else {
                return
            }

            textDocumentProxy.performWithoutNotifications {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(". ")
            }
        }
    }
    
}
