//
//  KeyboardEmojiCollectionSectionHeaderView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


internal final class KeyboardEmojiCollectionSectionHeaderView: UICollectionReusableView {

    internal static let reuseIdentifier = "KeyboardEmojiCollectionSectionHeaderView"

    private var labelView: UILabel!

    internal var emojiCategory: KeyboardEmojiCategory = .None {
        didSet {
            if oldValue != self.emojiCategory {
                self.updateEmojiCategory()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel()
        self.labelView.textAlignment = .left
        self.labelView.font = UIFont.systemFont(ofSize: 18.0)
//        self.labelView.transform = CGAffineTransformMakeRotation(-90 * CGFloat(M_PI) / 180);

//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.red.CGColor
//
        self.addSubview(self.labelView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.labelView.frame = self.bounds

//        let bounds = self.bounds
//        let labelViewFrame = CGRect(origin: CGPointZero, size: CGSize(width: bounds.size.height, height: bounds.size.width))
//        self.labelView.frame = self.bounds
    }

    private func updateEmojiCategory() {
        self.labelView.text = String(describing: self.emojiCategory)
    }
}
