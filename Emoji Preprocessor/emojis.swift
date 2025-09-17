//
//  KeyboardEmojiCategory.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/18/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//


public let predefinedEmojis: [KeyboardEmoji] = {

    var emojis: [KeyboardEmoji] = []

    var count = predefinedEmojiCharacters.count
    emojis.reserveCapacity(count)

    for i in stride(from: 0, to: count, by: 1) {
        emojis.append(
            KeyboardEmoji(
                character: predefinedEmojiCharacters[i],
                name: predefinedEmojiNames[i],
                shortNames: predefinedEmojiShortNames[i].components(separatedBy: ";"),
                keywords: predefinedEmojiKeywords[i].components(separatedBy: ";"),
                category: predefinedEmojiCategories[i]
            )
        )
    }

    return emojis
} ()
