//
//  GiftCardCartSceneConfigurator.swift
//  Gift Card
//
//

import UIKit

class GiftCardCartSceneConfigurator {
    
    // configure Gift Card Cart VC
    // attach interactor and router with view
    static func configure() -> UIViewController {
        let view = GiftCardCartVC()
        let router = GiftCardCartRouter()
        router.viewController = view
        view.router = router
        return view
    }
}
