//
//  KeyboardKeyPreviewPopupView.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal final class KeyboardKeyPreviewPopupView: KeyboardKeyPopupView {

    internal var labelView: UILabel!

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        self.labelView = UILabel(frame: self.bounds)
        self.labelView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.labelView.textAlignment = .center
        self.labelView.baselineAdjustment = .alignCenters // TODO: Rethink!
        self.labelView.font = UIFont.systemFont(ofSize: 44.0)
        self.labelView.adjustsFontSizeToFitWidth = true
        self.labelView.minimumScaleFactor = CGFloat(0.1)
        self.labelView.isUserInteractionEnabled = false
        self.labelView.numberOfLines = 1
        self.labelView.frame = self.bounds
        self.addSubview(self.labelView)
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
