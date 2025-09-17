//
//  DispatchOnce.swift
//  KeyboardKit
//
//  Created by 任盼盼 on 2025/9/17.
//  Copyright © 2025 AnchorFree. All rights reserved.
//

import Foundation

enum _DispatchOnce {

    static func run(_ block: () -> Void) {
        struct Once {
            static var executed = false
            static let queue = DispatchQueue(label: "com.example.runOnceInFunction")
        }
        Once.queue.sync {
            guard !Once.executed else { return }
            Once.executed = true
            block()
        }
    }
}
