//
//  String+cases.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/21/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


extension String {
    func isCamelcase() -> Bool {
        return self.uppercased() != self && self.lowercased() != self
    }

    func isUppercase() -> Bool {
        return self.uppercased() == self
    }

    func isLowercase() -> Bool {
        return self.lowercased() == self
    }
}
