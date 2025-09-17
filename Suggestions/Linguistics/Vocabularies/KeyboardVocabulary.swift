//
//  KeyboardVocabulary.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/21/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation
import UIKit


extension UITextChecker {

    func isValidWord(nsWord word: NSString, nsLanguage: NSString) -> Bool {

        guard word.rangeOfCharacter(from: cachedNonLetterCharacterSet).location == NSNotFound else {
            return false
        }

        guard nsLanguage.isEqual("en") else {
            return true
        }

        guard word.length > 2 else {
            return false
        }

        return word.canBeConverted(to: NSASCIIStringEncoding)
    }

    func completions(_ word: String, language: String) -> [String] {
        let nsLanguage = language as NSString
        let nsWord = word as NSString
        let nsRange = NSRange(location: 0, length: nsWord.length)

        guard self.isValidWord(nsWord: nsWord, nsLanguage: nsLanguage) else { return [] }

        return completions(
            forPartialWordRange: nsRange,
            in: nsWord as String,
            language: nsLanguage as String
        ) ?? []
    }

    func guesses(_ word: String, language: String) -> [String] {
        let nsLanguage = language as NSString
        let nsWord: NSString = word as NSString
        let nsRange = NSRange(location: 0, length: nsWord.length)

        guard self.isValidWord(nsWord: nsWord, nsLanguage: nsLanguage) else { return [] }

        return guesses(
            forWordRange: nsRange,
            in: nsWord as String,
            language: nsLanguage as String
        ) ?? []
    }

    func isMisspelled(_ word: String, language: String) -> Bool {
        let nsLanguage = language as NSString
        let nsWord = word as NSString
        let nsRange = NSRange(location: 0, length: nsWord.length)

        guard self.isValidWord(nsWord: nsWord, nsLanguage: nsLanguage) else { return false }

        return self.rangeOfMisspelledWord(
            in: nsWord as String,
            range: nsRange,
            startingAt: 0,
            wrap: false,
            language: nsLanguage as String
        ).location == NSNotFound
    }
}


private let maxCompletionsCount = 10
private let maxCorrectionsCount = 100


internal class KeyboardVocabulary {
    internal let language: String

    private let words: [String: Int]
    private let checker = UITextChecker()

    internal init(language: String, commaSeparatedWords: String = "") {
        self.language = language

        var score = 0
        var words: [String: Int] = [:]
        for word in commaSeparatedWords.components(separatedBy: ",") {
            words[word] = score
            score += 1
        }

        self.words = words
    }

    internal func score(_ word: String) -> Int? {
        return self.words[word]
    }

    internal func completions(_ query: KeyboardSuggestionQuery) -> [String] {
        let prefix = query.placement

        guard !prefix.isEmpty else {
            return []
        }

        let lowercasePrefix = prefix.lowercased()
        let prefixLength = prefix.count

        var scoredComplitions: [(word: String, score: Int)] = []

        for (word, score) in self.words {
            if word.hasPrefix(lowercasePrefix) {
                guard word.count > prefixLength else {
                    continue
                }

                let startIndex = word.index(word.startIndex, offsetBy: prefixLength)
                let word = prefix + String(word[startIndex...])

                scoredComplitions.append((word: word, score: score))
            }
        }

        /*
        // This is crashing sometimes.
        var checkerCompletions =
            checker.completionsForPartialWordRange(
                query.range,
                inString: query.context,
                language: self.language
            ) as? [String] ?? []
        */

        if !prefix.isEmpty {
            let checkerCompletions = checker.completions(prefix, language: self.language)
            let scoredCheckerCompletions = checkerCompletions.map { (word: $0, score: self.words[$0] ?? (100000 + $0.count) ) }
            scoredComplitions += scoredCheckerCompletions
        }

        // Filter

        // Sort
        scoredComplitions.sort {
            $0.score < $1.score
        }

        var completions = scoredComplitions.map { $0.word }

        if completions.count > maxCompletionsCount {
            completions = Array(completions.prefix(maxCompletionsCount))
        }

        // Applying all-caps if needed.
        if prefixLength > 1 && prefix == prefix.uppercased() {
            completions = completions.map { $0.uppercased() }
        }

        return completions
    }

    internal func corrections(_ query: KeyboardSuggestionQuery) -> [String] {
        /*
        return checker.guessesForWordRange(
                query.range,
                inString: query.context,
                language: self.language
            ) as? [String] ?? []
        */
        let placement = query.placement

        guard !placement.isEmpty else {
            return []
        }

        var corrections = self.checker.guesses(placement, language: self.language)

        if corrections.count > maxCorrectionsCount {
            corrections = Array(corrections.prefix(maxCorrectionsCount))
        }

        return corrections
    }

    internal func isSpellProperly(_ query: KeyboardSuggestionQuery) -> Bool {
        let placement = query.placement

        guard !placement.isEmpty else {
            return true
        }

        if self.words[placement.lowercased()] != nil {
            return true
        }

        /*
        return self.checker.rangeOfMisspelledWordInString(
                query.context,
                range: query.range,
                startingAt: query.range.location,
                wrap: false,
                language: self.language
            ).location == NSNotFound
        */

        return self.checker.isMisspelled(placement, language: self.language)
    }

}


extension KeyboardVocabulary {
    static var cachedVocabularies: [String: KeyboardVocabulary?] = [:]

    static func vocabulary(language: String) -> KeyboardVocabulary? {
        
        guard language.count >= 2 else {
            return nil
        }

        // Predefined
        let startIndex = language.index(language.startIndex, offsetBy: 2)

        switch language[startIndex...].lowercased() {
        case "en":
            return englishVocabulary
        case "ru":
            return russianVocabulary
        default:
            break
        }

        //
        if let vocabulary = self.cachedVocabularies[language] {
            return vocabulary
        }

        let vocabulary = KeyboardVocabulary(language: language)
        self.cachedVocabularies[language] = vocabulary
        return vocabulary
    }
}
