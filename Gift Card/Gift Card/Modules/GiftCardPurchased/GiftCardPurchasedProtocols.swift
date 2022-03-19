//
//  GiftCardPurchasedProtocols.swift
//  Gift Card
//
//

import Foundation

// Gift Card Purchased Display View
protocol GiftCardPurchasedSceneDisplayView: AnyObject {
    var interactor: GiftCardPurchasedSceneBusinessLogic? { get }
}

// Gift Card Purchased Display View Interactor
protocol GiftCardPurchasedSceneBusinessLogic: AnyObject {
    var cards: [GiftCardModel] { get }
}
