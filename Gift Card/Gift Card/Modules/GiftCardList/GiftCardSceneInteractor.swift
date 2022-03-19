//
//  GiftCardSceneInteractor.swift
//  Gift Card
//
//

import UIKit

class GiftCardInteractor {
    var presenter: GiftCardScenePresentationLogic?
    
    init(presenter: GiftCardScenePresentationLogic?) {
        self.presenter = presenter
    }
}

extension GiftCardInteractor: GiftCardSceneBusinessLogic {
    
    // load cards from server
    // check if presenter is not null then pass api response to it 
    func getCards() {
        ApiService.shared.executeRequest(withApi: ApiRepo.getCards) { [weak self] (result: Result<[GiftCardModel], Error>) in
            self?.presenter?.didGetCards(result)
        }
    }
}
