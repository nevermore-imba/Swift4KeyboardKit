//
//  KeyboardSuggestionsViewControllerDelegate.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 3/24/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

public protocol KeyboardSuggestionsViewControllerDelegate: AnyObject {
    func suggestionsViewControllerWillUpdateSuggestionItems(query: KeyboardSuggestionQuery)
    func suggestionsViewControllerDidUpdateSuggestionItems(query: KeyboardSuggestionQuery)
}
