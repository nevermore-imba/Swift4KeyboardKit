//
//  KeyboardTextDocumentObserver.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public protocol KeyboardTextDocumentObserver: AnyObject {
    var observesTextDocumentEvents: Bool {get}

    func keyboardTextDocumentWillInsertText(_ text: String)
    func keyboardTextDocumentDidInsertText(_ text: String)

    func keyboardTextDocumentWillDeleteBackward()
    func keyboardTextDocumentDidDeleteBackward()

    func keyboardTextDocumentWillChange()
    func keyboardTextDocumentDidChange()

    func keyboardTextInputTraitsDidChange(_ textInputTraits: UITextInputTraits)
}

// # Making these methods optional
extension KeyboardTextDocumentObserver {
    
    public var observesTextDocumentEvents: Bool {
        return true
    }

    public func keyboardTextDocumentWillInsertText(_ text: String) {}
    public func keyboardTextDocumentDidInsertText(_ text: String) {}

    public func keyboardTextDocumentWillDeleteBackward() {}
    public func keyboardTextDocumentDidDeleteBackward() {}

    public func keyboardTextDocumentWillChange() {}
    public func keyboardTextDocumentDidChange() {}

    public func keyboardTextInputTraitsDidChange(_ textInputTraits: UITextInputTraits) {}
}
