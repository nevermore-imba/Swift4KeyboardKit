//
//  KeyboardTextDocumentCoordinator.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

private var enablesNotifications = true
private var enablesDefaultBehaviour = true

private var textDocumentWillInsertText: ((_ text: String) -> Void)?
private var textDocumentDidInsertText: ((_ text: String) -> Void)?
private var textDocumentWillDeleteBackward: (() -> Void)?
private var textDocumentDidDeleteBackward: (() -> Void)?

private var textWillChange: (() -> Void)?
private var textDidChange: (() -> Void)?

private var isPreventingDefault: Bool = false

extension UITextDocumentProxy {

    public func performWithoutNotifications(block: () -> Void) {
        enablesNotifications = false
        block()
        enablesNotifications = true

        textWillChange?()
        textDidChange?()
    }

}


public final class KeyboardTextDocumentCoordinator {
    private var observers = WeakSet<KeyboardTextDocumentObserver>()
    private weak var inputViewController: UIInputViewController?
    private var textInputTraitsObserver: KeyboardTextInputTraitsObserver!

    public static var sharedInstance: KeyboardTextDocumentCoordinator = {
        return KeyboardTextDocumentCoordinator(inputViewController: UIInputViewController.rootInputViewController)
    } ()

    private init(inputViewController: UIInputViewController) {
        self.inputViewController = inputViewController

        self.textInputTraitsObserver = KeyboardTextInputTraitsObserver(handler: { [unowned self] textInputTraits in
            CATransaction.begin()
            CATransaction.setDisableActions(true)

            for observer in self.observers {
                guard observer.observesTextDocumentEvents else { continue }
                observer.keyboardTextInputTraitsDidChange(textInputTraits)
            }

            CATransaction.commit()
        })

         self.swizzleAll()
    }

    // # Public

    public func addObserver(_ observer: KeyboardTextDocumentObserver) {
        self.observers.insert(observer)
    }

    public func removeObserver(_ observer: KeyboardTextDocumentObserver) {
        self.observers.remove(observer)
    }

    public func performWithoutNotifications(block: () -> Void) {
        enablesNotifications = false
        block()
        enablesNotifications = true
    }

    public func preventDefault() {
        isPreventingDefault = true
    }

    // # Dispatch

    // keyboardTextDocument(Will/Did)InsertText()
    internal func dispatchKeyboardTextDocumentWillInsertText(_ text: String) {
        log("keyboardTextDocumentWillInsertText(\"\(text)\")")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillInsertText(text)
        }
    }

    internal func dispatchKeyboardTextDocumentDidInsertText(_ text: String) {
        log("keyboardTextDocumentDidInsertText(\"\(text)\")")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidInsertText(text)
        }
    }

    // keyboardTextDocument(Will/Did)DeleteBackward()
    internal func dispatchTextDocumentWillDeleteBackward() {
        log("dispatchTextDocumentWillDeleteBackward()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillDeleteBackward()
        }
    }

    internal func dispatchTextDocumentDidDeleteBackward() {
        log("dispatchTextDocumentDidDeleteBackward()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidDeleteBackward()
        }
    }

    // keyboardText(Will/Did)Change()
    internal func dispatchTextWillChange() {
        log("dispatchTextWillChange()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentWillChange()
        }
    }

    internal func dispatchTextDidChange() {
        log("dispatchTextDidChange()")
        for observer in self.observers {
            guard observer.observesTextDocumentEvents else { continue }
            observer.keyboardTextDocumentDidChange()
        }
    }

    // # Private

    private func swizzleAll() {
        guard
            let inputViewController = self.inputViewController,
            let textDocumentProxy = self.inputViewController?.textDocumentProxy else
        {
            return
        }

        _DispatchOnce.run {
            self.swizzleInsertText(textDocumentProxy: textDocumentProxy)
            self.swizzleDeleteBackward(textDocumentProxy: textDocumentProxy)

            self.swizzleTextWillChange(inputViewController: inputViewController)
            self.swizzleTextDidChange(inputViewController: inputViewController)
        }
    }

    private func swizzleInsertText(textDocumentProxy: UITextDocumentProxy) {

        textDocumentWillInsertText = { [unowned self] text in
            guard enablesNotifications else { return }
            self.dispatchKeyboardTextDocumentWillInsertText(text)
        }

        textDocumentDidInsertText = { [unowned self] text in
            guard enablesNotifications else { return }
            self.dispatchKeyboardTextDocumentDidInsertText(text)
        }

        let target = type(of: textDocumentProxy)
        let action = Selector(("originalInsertText:"))

        guard let originalMethod = class_getInstanceMethod(
            target,
            #selector(UITextDocumentProxy.insertText(_:))
        ) else { return }

        let swizzledImplementation: @convention(block) (NSObject, Selector, String) -> Void = { _self, _cmd, text in
            textDocumentWillInsertText?(text)
            if isPreventingDefault { isPreventingDefault = false; return }
            _self.perform(action, with: text)
            textDocumentDidInsertText?(text)
        }

        let originalImplementation = method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
        )

        class_addMethod(
            target,
            action,
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleDeleteBackward(textDocumentProxy: UITextDocumentProxy) {

        textDocumentWillDeleteBackward = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDocumentWillDeleteBackward()
        }

        textDocumentDidDeleteBackward = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDocumentDidDeleteBackward()
        }

        let target = type(of: textDocumentProxy)
        let action = Selector(("originalDeleteBackward"))

        guard let originalMethod = class_getInstanceMethod(target, #selector(UITextDocumentProxy.deleteBackward)) else {
            return
        }

        let swizzledImplementation: @convention(block) (NSObject, Selector) -> Void = { (_self, _cmd) in
            textDocumentWillDeleteBackward?()
            if isPreventingDefault {
                isPreventingDefault = false
                return
            }
            _self.perform(action)
            textDocumentDidDeleteBackward?()
        }

        let originalImplementation =
        method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
        )

        class_addMethod(
            target,
            action,
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleTextWillChange(inputViewController: UIInputViewController) {

        textWillChange = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextWillChange()
        }

        let target = type(of: inputViewController)
        let action = Selector(("originalTextWillChange:"))

        guard let originalMethod = class_getInstanceMethod(target, #selector(UIInputViewController.textWillChange(_:))) else { return }

        let swizzledImplementation: @convention(block) (NSObject, Selector, AnyObject) -> Void = { (_self, _cmd, textInput) in
            _self.perform(action, with: textInput)
            textWillChange?()
        }

        let originalImplementation =
        method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
        )

        class_addMethod(
            target,
            action,
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }

    private func swizzleTextDidChange(inputViewController: UIInputViewController) {

        textDidChange = { [unowned self] in
            guard enablesNotifications else { return }
            self.dispatchTextDidChange()
        }

        let target = type(of: inputViewController)
        let action = Selector(("originalTextDidChange:"))

        guard let originalMethod = class_getInstanceMethod(target, #selector(UIInputViewController.textDidChange(_:))) else {
            return
        }

        let swizzledImplementation: @convention(block) (NSObject, Selector, AnyObject) -> Void = { (_self, _cmd, textInput) in
            _self.perform(action, with: textInput)
            textDidChange?()
        }

        let originalImplementation = method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
        )

        class_addMethod(
            target,
            action,
            originalImplementation,
            method_getTypeEncoding(originalMethod)
        )
    }
}
