//
//  GiftCardDetailsSceneInteractor.swift
//  Gift Card
//
//

import Foundation

class GiftCardPurchasedSceneInteractor {
    var cards: [GiftCardModel]
    
    init(cards: [GiftCardModel]) {
        self.cards = cards
    }
}

extension GiftCardPurchasedSceneInteractor: GiftCardPurchasedSceneBusinessLogic {}
