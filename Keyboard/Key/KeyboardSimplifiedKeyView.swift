//
//  KeyboardSimplifiedKeyView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit

public class KeyboardSimplifiedKeyView: KeyboardKeyView {

    public var appearanceAdjustCallback: ((_ appearance: KeyboardKeyAppearance, _ keyView: KeyboardSimplifiedKeyView) -> (KeyboardKeyAppearance))?

    private var highlightedValueObservation: NSKeyValueObservation?

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.appearanceManager = defaultAppearanceManager
        
        KeyboardTextDocumentCoordinator.sharedInstance.addObserver(self)

        highlightedValueObservation = observe(\.isHighlighted, options: .new, changeHandler: { [weak self] keyView, change in
            guard let self else { return }
            let highlighted = change.newValue ?? keyView.isHighlighted
            self.keyMode.highlightMode = highlighted ? .Highlighted : .None
            self.applySuitableAppearance()
        })

    }

    public required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    internal override func updateAppearance() {
        if let callback = self.appearanceAdjustCallback {
            self.appearance = callback(self.appearance, self)
        }

        super.updateAppearance()
    }

    public override var intrinsicContentSize: CGSize {
        var size: CGSize = CGSize()
        switch self.keyboardMode.sizeMode {
        case .Small:
            size.height = 39
            size.width = 34
            break
        case .Big:
            let iPadRatio = CGFloat(1.4)
            size.height = 39 * iPadRatio
            size.width = 34 * iPadRatio
            break
        }

        return size
    }

    /*
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if self.pointInside(point, withEvent: event) {
            return self
        }

        return nil
    }
    */

    public override func didMoveToWindow() {
        super.didMoveToWindow()
        self.applySuitableAppearance()
    }

    private func applySuitableAppearance() {
        guard let appearanceManager = self.appearanceManager else {
            return
        }

        let textInputTraits: UITextInputTraits = UIInputViewController.rootInputViewController.textDocumentProxy
        self.keyboardMode = KeyboardMode(textInputTraits: textInputTraits)

        var appearanceVariant = KeyboardKeyAppearanceVariant()
        appearanceVariant.keyType = self.key.type
        appearanceVariant.keyMode = self.keyMode
        appearanceVariant.keyboardMode = self.keyboardMode

        self.appearance = appearanceManager.createAppearanceForVariant(appearanceVariant)

        self.updateIfNeeded()
    }

}

extension KeyboardSimplifiedKeyView: KeyboardTextDocumentObserver {
    public func keyboardTextInputTraitsDidChange(_ textInputTraits: UITextInputTraits) {
        self.applySuitableAppearance()
    }
}
