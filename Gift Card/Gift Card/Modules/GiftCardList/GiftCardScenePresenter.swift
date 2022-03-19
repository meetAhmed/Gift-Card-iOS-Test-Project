//
//  GiftCardScenePresenter.swift
//  Gift Card
//
//

import Foundation

class GiftCardPresenter {
    var displayView: GiftCardDisplayView?
    
    init(displayView: GiftCardDisplayView?) {
        self.displayView = displayView
    }
}

extension GiftCardPresenter: GiftCardScenePresentationLogic {
    
    // check api response
    func didGetCards(_ status: Result<[GiftCardModel], Error>) {
        switch status {
        case .success(let cards):
            // show cards on view
            displayView?.didGetCards(cards: cards.shuffled())
            break
        case .failure(let error):
            // show error to user
            displayView?.failedToGetCards(message: error.localizedDescription)
            break
        }
    }
}
