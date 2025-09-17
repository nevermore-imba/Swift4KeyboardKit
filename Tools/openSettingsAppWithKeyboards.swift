//
//  openSettingsAppWithKeyboards.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/16/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public func openSettingsAppWithKeyboards() {
    // Original URL: "prefs:root=General&path=Keyboard/KEYBOARDS"
    let parts = ["prefs", ":", "root", "=", "General", "&", "path", "=", "Keyboard", "/", "KEYBOARDS"]

    if let settingsURL = URL(string: parts.joined(separator: "")) {
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
            // Successfully open internal Keyboard Settings screen.
            return
        }
    }

    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        UIApplication.shared.open(settingsURL)
    }
}
