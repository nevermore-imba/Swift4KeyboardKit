//
//  KeyboardSuggestionModelDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 6/15/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation


public protocol KeyboardSuggestionModelDelegate: AnyObject {
    func suggestionModelWillUpdateGuesses(query: KeyboardSuggestionQuery)
    func suggestionModelDidUpdateGuesses(query: KeyboardSuggestionQuery, guesses: [KeyboardSuggestionGuess])
}
