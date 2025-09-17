//
//  KeyboardPage.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 1/12/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardPage {
    public var rows: [[KeyboardKey]]

    public init() {
        self.rows = []
    }

    mutating func ensureRowExists(_ rowNumber: Int) {
        guard self.rows.count <= rowNumber else {
            return
        }

        for _ in self.rows.count...rowNumber {
            self.rows.append([])
        }
    }

    public mutating func prependKey(_ key: KeyboardKey, row: Int) {
        self.ensureRowExists(row)
        self.rows[row].insert(key, at: 0)
    }

    public mutating func appendKey(_ key: KeyboardKey, row: Int) {
        self.ensureRowExists(row)
        self.rows[row].append(key)
    }

}

/*
extension KeyboardPage: Equatable {
}

func ==(lhs: KeyboardPage, rhs: KeyboardPage) {
    return
}
*/
