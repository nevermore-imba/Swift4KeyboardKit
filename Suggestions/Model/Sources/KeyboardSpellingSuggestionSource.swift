//
//  KeyboardSpellingSuggestionSource.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 4/8/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


internal final class KeyboardSpellingSuggestionSource: KeyboardSuggestionSource {

    private let queue: DispatchQueue = {
        if arc4random() % 10 == 0 {
            return .main
        }
        return DispatchQueue(label: "com.keyboard-kit.spelling-suggestion-source")
    }()

    private let sortingModel = KeyboardSuggestionGuessesSortingModel()
    private var lastQuery: KeyboardSuggestionQuery?
    private let checker = UITextChecker()

    private var replacementPhrases: [String: String] = [:]
    private var replacementNames: [String: String] = [:]

    internal weak var keyboardViewController: KeyboardViewController? {
        didSet {
            self.sortingModel.keyboardViewController = self.keyboardViewController
        }
    }

    internal init() {
        self.sortingModel.keyboardViewController = nil
        self.learnAllWordsFromLexicon()
    }

    internal func learnWord(_ word: String) {
        queue.async { [weak self] in
            guard let checker = self?.checker else {
                return
            }

            // Learn this word _globally_.
            type(of: checker).learnWord(word)
        }
    }

    private func learnAllWordsFromLexicon() {
        queue.async { [weak self] in
            guard let self else { return }

            let inputViewController = UIInputViewController.rootInputViewController

            let semaphore = DispatchSemaphore(value: 0)
            var lexicon: UILexicon!
            inputViewController.requestSupplementaryLexicon() { supplementaryLexicon in
                lexicon = supplementaryLexicon
                semaphore.signal()
            }
            semaphore.wait()

            var replacementPhrases: [String: String] = [:]
            var replacementNames: [String: String] = [:]

            for entry in lexicon.entries {
                if entry.documentText == entry.userInput {
                    if entry.documentText.isCamelcase() {
                        replacementNames[entry.userInput.lowercased()] = entry.documentText
                    }
                }
                else {
                    replacementPhrases[entry.userInput.lowercased()] = entry.documentText
                }
            }

            // TODO: Move outside.
            replacementPhrases["i"] = "I"

            self.replacementPhrases = replacementPhrases
            self.replacementNames = replacementNames
        }
    }

    internal func suggest(_ query: KeyboardSuggestionQuery, callback: @escaping KeyboardSuggestionSourceCallback) {
        self.lastQuery = query

        let sortingModel = self.sortingModel

        queue.async { [weak self] in
            guard let strongSelf = self else {
                return
            }

            guard self?.lastQuery == query else {
                return
            }

            guard let vocabulary = KeyboardVocabulary.vocabulary(language: query.language) else {
                return
            }

            var guesses: [KeyboardSuggestionGuess] = []

            // `defer` block must be placed after all `guard`s.
            defer {
                DispatchQueue.main.async {
                    callback(guesses)
                }
            }

            log("placement: \"\(query.placement)\"")

            let isSpellProperly = vocabulary.isSpellProperly(query)
            let completions = vocabulary.completions(query)
            let unsortedCorrections = vocabulary.corrections(query)
            let corrections = sortingModel.sortReplacements(unsortedCorrections, placement: query.placement)

            var automatic = false
            var hasAutoreplacement = false
            let placementLength = query.placement.count

            log("isSpellProperly: \(isSpellProperly), corrections: \(corrections), completions: \(completions)")

            var replacements = Set<String>()

            // Autoreplacement
            if let replacement = strongSelf.replacementPhrases[query.placement.lowercased()], !replacements.contains(replacement) && query.placement != replacement {

                replacements.insert(replacement)

                automatic = true

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Autoreplacement,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Name Capitalization
            if let replacement = strongSelf.replacementNames[query.placement.lowercased()], !replacements.contains(replacement) && query.placement != replacement {

                replacements.insert(replacement)

                automatic = vocabulary.score(replacement.lowercased()) == nil

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Capitalization,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Corrections
            for correction in corrections {
                let replacement = correction
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                automatic = !isSpellProperly

                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Correction,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Completions
            for completion in completions {
                let replacement = completion
                guard !replacements.contains(replacement) else {
                    continue
                }

                replacements.insert(replacement)

                automatic = !isSpellProperly && placementLength > 1
                guesses.append(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Completion,
                        replacement: replacement,
                        automatic: automatic
                    )
                )

                hasAutoreplacement = hasAutoreplacement || automatic
            }

            // Learning
            if hasAutoreplacement {
                guesses.insert(
                    KeyboardSuggestionGuess(
                        query: query,
                        type: .Learning,
                        replacement: query.placement
                    ),
                    at: 0
                )
            }

            // `defer {}` will call `callback`.
        }
    }

}
