//
//  log.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 5/11/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import Foundation

internal func log<T>(_ argument: T, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    guard _isDebugAssertConfiguration() else {
        return
    }
    
    let fileName = URL(fileURLWithPath: file, isDirectory: false).deletingPathExtension().lastPathComponent

    print("KeyboardKit/\(fileName)@\(line): \(argument)")
}
