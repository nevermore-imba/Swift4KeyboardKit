//
//  KeyboardEmojiSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardEmojiSuggestionSource: KeyboardSuggestionSource {

    static let emojiMap: [String: [KeyboardEmoji]] = {
        var map = [String: [KeyboardEmoji]]()

        func addEmoji(_ emoji: KeyboardEmoji, forKey key: String?) {
            guard let key = key else {
                return
            }

            if map[key] == nil {
                map[key] = []
            }

            map[key]!.append(emoji)
        }

        for emoji in predefinedEmojis {
            addEmoji(emoji, forKey: emoji.name?.lowercased())

            for shortname in emoji.shortNames ?? [] {
                addEmoji(emoji, forKey: shortname.lowercased())
            }

            for keyword in emoji.keywords ?? [] {
                addEmoji(emoji, forKey: keyword.lowercased())
            }
        }

        return map
    }()


    func suggest(_ query: KeyboardSuggestionQuery, callback: KeyboardSuggestionSourceCallback) {
        let keyword = query.placement.lowercased().trim()

        guard !keyword.isEmpty else {
            callback([])
            return
        }

        let emojis = type(of: self).emojiMap[keyword] ?? []

        let guesses: [KeyboardSuggestionGuess] = emojis.map { emoji in
            let guess = KeyboardSuggestionGuess(
                query: query,
                type: .Emoji,
                replacement: emoji.character
            )

            return guess
        }

        callback(guesses)
    }

}
