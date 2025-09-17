//
//  KeyboardEmoji.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public struct KeyboardEmoji {
    let character: String
    let name: String?
    let shortNames: [String]?
    let keywords: [String]?
    let category: KeyboardEmojiCategory?
}


extension KeyboardEmoji: Equatable {}

extension KeyboardEmoji: Hashable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.character == rhs.character
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(character)
    }
}
