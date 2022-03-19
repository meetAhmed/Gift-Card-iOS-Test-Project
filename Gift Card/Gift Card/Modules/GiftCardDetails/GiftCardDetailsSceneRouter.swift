//
//  GiftCardDetailsSceneRouter.swift
//  Gift Card
//

import UIKit

class GiftCardDetailsRouter {
    weak var viewController: (UIViewController & GiftCardDetailsSceneDisplayView)?
}

extension GiftCardDetailsRouter: GiftCardDetailsSceneRoutingLogic {
    
    // move to purchased view 
    func routeToPurchaseView(with card: GiftCardModel) {
        let purchasedVC = GiftCardPurchasedSceneConfigurator.configure(with: [card])
        viewController?.navigationController?.pushViewController(purchasedVC, animated: true)
    }
}
