//
//  Object+Queue.swift
//  sfunctional
//
//  Created by rarnu on 26/03/2018.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit

public extension NSObject {
    func thread(_ b:@escaping () -> Void) {
        Thread.detachNewThread(b)
    }
    func mainThread(_ b:@escaping () -> Void) {
        OperationQueue.main.addOperation(b)
    }
}

public extension UIView {
    func viewController() -> UIViewController? {
        var result: UIViewController? = nil
        var responder = self.next
        while (true) {
            if (responder != nil) {
                if (!responder!.isKind(of: UIViewController.classForCoder()) && !responder!.isKind(of: UIWindow.classForCoder())) {
                    responder = responder!.next
                } else {
                    break
                }
            } else {
                break
            }
        }
        if (responder != nil) {
            if (responder!.isKind(of: UIViewController.classForCoder())) {
                result = responder as? UIViewController
            }
        }
        return result
    }
}

public extension UIViewController {
    func navigationbarHeight() -> CGFloat {
        let h = navigationController?.navigationBar.frame.size.height
        return (h == nil) ? 0 : h!
    }
}
