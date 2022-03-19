//
//  GiftCardSceneRouter.swift
//  Gift Card
//
//

import UIKit

class GiftCardSceneRouter {
    weak var viewController: (UIViewController & GiftCardDisplayView)?
}

extension GiftCardSceneRouter: GiftCardSceneRoutingLogic {
    
    // move to details page
    func routeToDetails(with card: GiftCardModel) {
        let detailsVC = GiftCardDetailsSceneConfigurator.configure(with: card)
        viewController?.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // move to cart page
    func routeToCart() {
        let cartVC = GiftCardCartSceneConfigurator.configure()
        viewController?.navigationController?.pushViewController(cartVC, animated: true)
    }
}
