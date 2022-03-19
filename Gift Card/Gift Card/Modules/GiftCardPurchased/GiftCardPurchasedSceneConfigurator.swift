//
//  GiftCardDetailsSceneConfigurator.swift
//  Gift Card
//
//

import UIKit

class GiftCardPurchasedSceneConfigurator {
    
    // configure Gift Card Purchased VC
    // attach interactor with view
    static func configure(with cards: [GiftCardModel]) -> UIViewController {
        let view = GiftCardPurchasedVC()
        let interactor = GiftCardPurchasedSceneInteractor(cards: cards)
        view.interactor = interactor
        return view
    }
}
