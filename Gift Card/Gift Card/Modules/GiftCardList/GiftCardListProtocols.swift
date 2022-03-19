//
//  GiftCardListProtocols.swift
//  Gift Card
//

import UIKit

// Gift Card Model
public struct GiftCardModel: Decodable, Equatable {
    let id, vendor, brand: String
    let image: String
    let denominations: [Denomination]
    let discount: Double
    let terms: String
    
    public static func == (lhs: GiftCardModel, rhs: GiftCardModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(id: String) {
        self.id = id
        vendor = ""
        brand = ""
        image = ""
        denominations = []
        discount = 0.0
        terms = ""
    }
}

// Denomination Model
struct Denomination: Decodable {
    @Flexible var price: Int
    let currency: String
}

// Gift Card List View
protocol GiftCardDisplayView: AnyObject {
    var interactor: GiftCardSceneBusinessLogic? { get }
    var router: GiftCardSceneRoutingLogic? { get }

    func didGetCards(cards: [GiftCardModel])
    func failedToGetCards(message: String)
}

// Gift Card List View Interactor
protocol GiftCardSceneBusinessLogic: AnyObject {
    var presenter: GiftCardScenePresentationLogic? { get }
    
    func getCards()
}

// Gift Card List View Presenter
protocol GiftCardScenePresentationLogic: AnyObject {
    var displayView: GiftCardDisplayView? { get }
    
    func didGetCards(_ status: Result<[GiftCardModel], Error>)
}

// Gift Card List View Router
protocol GiftCardSceneRoutingLogic: AnyObject {
    var viewController: (GiftCardDisplayView & UIViewController)? { get }
    
    func routeToDetails(with card: GiftCardModel)
    func routeToCart()
}
