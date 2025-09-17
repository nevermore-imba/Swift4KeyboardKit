//
//  UIInputViewController+rootInputViewController.swift
//  KeyboardKit
//
//  Created by Valentin Shergin on 2/5/16.
//  Copyright © 2016 AnchorFree. All rights reserved.
//

import UIKit


private var storedInputViewControllers = WeakSet<UIInputViewController>()
private weak var storedInputViewController: UIInputViewController?


private func swizzleInit() {

    let target = UIViewController.self // Yes, `UIViewController`, not `UIInputViewController`.

    guard let originalMethod = class_getInstanceMethod(target, #selector(UIViewController.init(nibName:bundle:))) else { return }

    let action = Selector(("originalInitWithNibName:bundle:"))

    let swizzledImplementation: @convention(block) (NSObject, Selector, AnyObject, AnyObject) -> Unmanaged<AnyObject>? = { (_self, _cmd, nibName, bundle) in
        if let inputViewController = _self as? UIInputViewController {
            storedInputViewController = inputViewController
            storedInputViewControllers.insert(inputViewController)
        }
        return _self.perform(action, with: nibName, with: bundle)
    }

    let originalImplementation =
        method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
    )

    class_addMethod(
        target,
        action,
        originalImplementation,
        method_getTypeEncoding(originalMethod)
    )
}


private func swizzleSendEvent() {
    let type = UIApplication.self
    let action = Selector(("originalSendEvent:"))

    guard let originalMethod = class_getInstanceMethod(type, #selector(UIApplication.sendEvent(_:))) else {
        return
    }

    let swizzledImplementation: @convention(block) (UIApplication, Selector, UIEvent) -> Unmanaged<AnyObject>? = { _self, _cmd, event in

        if let view = event.allTouches?.first?.view {
            if let rootViewController = view.window?.rootViewController?.children.first as? UIInputViewController {
                if storedInputViewController != rootViewController {
                    storedInputViewController = rootViewController
                    log("🙀🔥 `UIInputViewController.rootInputViewController` was recovered.")
                }
            }
        }

        return _self.perform(action, with: event)
    }

    let originalImplementation =
        method_setImplementation(
            originalMethod,
            unsafeBitCast(swizzledImplementation, to: IMP.self)
    )

    class_addMethod(
        type,
        action,
        originalImplementation,
        method_getTypeEncoding(originalMethod)
    )
}


extension UIInputViewController {


    public class func swizzling() {
        _DispatchOnce.run {
            swizzleInit()
            swizzleSendEvent()
        }
    }

    public static var rootInputViewController: UIInputViewController {
        if let inputViewController = storedInputViewController {
            return inputViewController
        }

        guard let rootInputViewController = storedInputViewControllers.first else {
            fatalError("UIInputViewController: `rootInputViewController` was requested but there is no any.")
        }

        return rootInputViewController
    }

    internal static var optionalRootInputViewController: UIInputViewController? {
        /*
        // NB: This is too verbous.
        if storedInputViewController == nil {
            log("👻💥 `UIInputViewController.optionalRootInputViewController` was requested but it is nil.")
        }
        */
        return storedInputViewController
    }

    internal static var isRootInputViewControllerAvailable: Bool {
        return storedInputViewController != nil
    }

}
