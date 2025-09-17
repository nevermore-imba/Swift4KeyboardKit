//
//  KeyboardAlternateKeyView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/9/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardAlternateKeyView: UIView {

    internal var appearance: KeyboardKeyAppearance?

    internal var labelView: UILabel!

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel()
        self.labelView.textAlignment = .center
        self.labelView.baselineAdjustment = .alignCenters // TODO: Rethink!
        self.labelView.isUserInteractionEnabled = false
        self.labelView.numberOfLines = 1
        self.addSubview(self.labelView)
        self.backgroundColor = UIColor.gray
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal var key: KeyboardKey! {
        didSet {
            self.updateContent()
        }
    }
    internal var isHighlighted: Bool = false {
        didSet {
            self.updateContent()
        }
    }

    func updateContent() {
        let appearance = self.appearance
        let isHighlighted = self.isHighlighted

        self.labelView.font = appearance?.keycapTextFont
        self.labelView.text = self.key.label?.labelWithShiftMode(.Disabled)

        self.layer.cornerRadius = appearance?.bodyCornerRadius ?? 0
        self.labelView.textColor = isHighlighted ? appearance?.popupHighlightedTextColor : appearance?.popupTextColor
        self.backgroundColor = isHighlighted ? appearance?.popupHighlightedBackgroundColor : UIColor.clear
    }

    private var labelViewPadding: CGPoint {
        return CGPoint(x: 8, y: 4)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.labelView.frame = self.bounds.insetBy(dx: -self.labelViewPadding.x, dy: -self.labelViewPadding.y)
    }

    override func sizeThatFits(_ baseSize: CGSize) -> CGSize {
        var size = self.labelView.sizeThatFits(baseSize - self.labelViewPadding) + self.labelViewPadding
        size.width = max(size.width, 24)
        return size
    }
}
