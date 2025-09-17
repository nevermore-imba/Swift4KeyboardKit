//
//  KeyboardSoundController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/7/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit
import AudioToolbox


internal final class KeyboardSoundController: KeyboardKeyListenerProtocol {

    internal func keyViewDidSendEvents(controlEvents: UIControl.Event, keyView: KeyboardKeyView, key: KeyboardKey, keyboardMode: KeyboardMode) {
        if controlEvents.contains(.touchDown) {
            KeyboardSoundService.sharedInstance.playInputSound()
        } else if controlEvents == .touchDragEnter {
            KeyboardSoundService.sharedInstance.playInputSound()
        }
    }

}


public final class KeyboardSoundService {

    public static var sharedInstance = KeyboardSoundService()

    public var enablesTapticEngine: Bool = true
    public var enablesSound: Bool = true

    private let soundQueue = DispatchQueue(label: "com.keyboard-kit.sound-sound")
    private let tapticQueue = DispatchQueue(label: "com.keyboard-kit.taptic-feedback")

    private var soundQueueLength: Int = 0
    private var soundMaxQueueLength: Int = 2

    private var tapticQueueLength: Int = 0
    private var tapticMaxQueueLength: Int = 2

    private init() {
    }

    public lazy var isTapticEngineAvailable: Bool = {
        if #available(iOS 9.0, *) {
            return UIInputViewController.rootInputViewController.traitCollection.forceTouchCapability == .available
        }
        return false
    }()

    public func playInputSound() {
        if self.enablesSound {
            self.playSoundWithId(1104)
        }

        if self.enablesTapticEngine && self.isTapticEngineAvailable {
            self.playTapticWithId(1519)
        }
    }

    public func playAlternateInputSound() {
        if self.enablesTapticEngine && self.isTapticEngineAvailable {
            self.playTapticWithId(1521)
        }
    }

    private func playSoundWithId(_ soundId: SystemSoundID, queue: DispatchQueue, callback: @escaping () -> Void) {
        queue.async {
            if #available(iOS 9.0, *) {
                let semaphore = DispatchSemaphore(value: 0)
                AudioServicesPlaySystemSoundWithCompletion(soundId) {
                    semaphore.signal()
                }
                semaphore.wait()
            } else {
                AudioServicesPlaySystemSound(soundId)
            }

            DispatchQueue.main.async {
                callback()
            }
        }
    }

    private func playSoundWithId(_ soundId: SystemSoundID) {
        if self.soundQueueLength >= self.soundMaxQueueLength {
            return
        }

        self.soundQueueLength += 1

        self.playSoundWithId(soundId, queue: self.soundQueue) {
            self.soundQueueLength -= 1
        }
    }

    private func playTapticWithId(_ soundId: SystemSoundID) {
        if self.tapticQueueLength >= self.tapticMaxQueueLength {
            return
        }

        self.tapticQueueLength += 1

        self.playSoundWithId(soundId, queue: self.tapticQueue) {
            self.tapticQueueLength -= 1
        }
    }

}
