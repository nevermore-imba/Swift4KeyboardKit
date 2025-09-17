//
//  KeyboardKeyOutput.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/2/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardKeyOutput {
    public var lowercase: String
    public var uppercase: String

    public init(unified: String) {
        self.lowercase = unified
        self.uppercase = unified
    }

    public init(automated: String) {
        self.lowercase = automated.lowercased()
        self.uppercase = automated.uppercased()
    }

    public init(lowercase: String, uppercase: String) {
        self.lowercase = lowercase
        self.uppercase = uppercase
    }

    internal func outputWithShiftMode(_ shiftMode: KeyboardShiftMode) -> String {
        if shiftMode.needCapitalize() {
            return self.uppercase
        }
        else {
            return self.lowercase
        }
    }

}
