//
//  SceneDelegate.swift
//  Gift Card
//
//

import UIKit
import SVProgressHUD

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = UINavigationController(rootViewController: GiftCardSceneConfigurator.configure())
        window.makeKeyAndVisible()
        self.window = window
        SVProgressHUD.setForegroundColor(Constants.appColor)
    }
}

