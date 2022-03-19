//
//  AppWindowManager.swift
//  Gift Card
//
//  Created by Ahmed Ali on 03/02/2022.
//

import UIKit

enum AppWindowManager {
    static func setupWindow<T>(controller: T) where T: UIViewController {
        window = self.window ?? UIWindow.init(frame: windowFrame)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

private extension AppWindowManager {
    static var window: UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    static var windowFrame: CGRect {
        UIScreen.main.bounds
    }
}

