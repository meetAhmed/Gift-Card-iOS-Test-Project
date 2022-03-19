//
//  GiftCardCartSceneRouter.swift
//  Gift Card
//
//
import UIKit

class GiftCardCartRouter {
    weak var viewController: (UIViewController & GiftCardCartSceneDisplayView)?
}

extension GiftCardCartRouter: GiftCardCartSceneRoutingLogic {
    
    // move to purchased view
    func routeToPurchaseView(with cards: [GiftCardModel]) {
        let purchasedVC = GiftCardPurchasedSceneConfigurator.configure(with: cards)
        viewController?.navigationController?.pushViewController(purchasedVC, animated: true)
    }
}
