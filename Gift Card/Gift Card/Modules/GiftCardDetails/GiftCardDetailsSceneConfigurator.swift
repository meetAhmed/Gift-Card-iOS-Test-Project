//
//  GiftCardDetailsSceneConfigurator.swift
//  Gift Card
//
//

import UIKit

class GiftCardDetailsSceneConfigurator {
    
    // configure Gift Card Details VC
    // attach interactor and router with view
    static func configure(with card: GiftCardModel) -> UIViewController {
        let view = GiftCardDetailsVC()
        let interactor = GiftCardDetailsSceneInteractor()
        interactor.card = card
        view.interactor = interactor
        let router = GiftCardDetailsRouter()
        router.viewController = view
        view.router = router
        
        return view
    }
}
