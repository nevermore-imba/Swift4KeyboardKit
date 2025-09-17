//
//  NSCharacterSet+AdditionalSets.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/19/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal let cachedNewLineCharacterSet = CharacterSet.newlines
internal let cachedWhitespaceCharacterSet = CharacterSet.whitespaces

internal let cachedLowercaseLetterCharacterSet = CharacterSet.lowercaseLetters
internal let cachedUppercaseLetterCharacterSet = CharacterSet.uppercaseLetters
internal let cachedLetterCharacterSet = CharacterSet.letters
internal let cachedNonLetterCharacterSet = cachedLetterCharacterSet.inverted

internal let cachedSeparatorChracterSet: CharacterSet = {
    var characterSet = CharacterSet()
    characterSet.formUnion(.whitespaces)
    characterSet.formUnion(.newlines)
    characterSet.formUnion(.punctuationCharacters)
    return characterSet
} ()

internal let cachedEndOfSentenceChracterSet: CharacterSet = {
    return CharacterSet(charactersIn: ".?!")
} ()

internal let cachedEndOfSentenceAndNewLineChracterSet: CharacterSet = {
    var characterSet = CharacterSet()
    characterSet.formUnion(cachedEndOfSentenceChracterSet)
    characterSet.formUnion(cachedNewLineCharacterSet)
    return characterSet
} ()


extension CharacterSet {

    func characterIsMember(_ aCharacter: unichar) -> Bool {
        return (self as NSCharacterSet).characterIsMember(aCharacter)
    }

    static func separatorChracterSet() -> CharacterSet {
        return cachedSeparatorChracterSet
    }

    static func endOfSentenceChracterSet() -> CharacterSet {
        return cachedEndOfSentenceChracterSet
    }
}
