//
//  Gift_CardTests.swift
//  Gift CardTests
//
//  Created by Ahmed Ali on 06/02/2022.
//

import XCTest
@testable import Gift_Card

class GiftCardTests: XCTestCase {

    // Check if cart manager is working properly
    // create a dummy card
    // add to cart
    // check if cart has the dummy card
    func testIfCartHasCard() {
        let card = GiftCardModel(id: "1023")
        CartManager.shared.addToCart(card)
        XCTAssertTrue(CartManager.shared.isCardAlreadyAdded(card))
    }

    // Check if cart manager is working properly
    // create a dummy card
    // add to cart
    // check if cart has the dummy card
    // then remove it from cart
    // check if cart has dummy card or not
    func testIfCartCanRemoveCard() {
        let card = GiftCardModel(id: "10099")
        CartManager.shared.addToCart(card)
        XCTAssertTrue(CartManager.shared.isCardAlreadyAdded(card))
        CartManager.shared.removeFromCart(card)
        XCTAssertFalse(CartManager.shared.isCardAlreadyAdded(card))
    }
    
    // check if we get cards from api response
    // if some error occurs, then we should have error as non-nil
    func testGetCardsApi() {
        let expectations = self.expectation(description: "testGetCardsApi")
        ApiService.shared.executeRequest(withApi: ApiRepo.getCards) { (result: Result<[GiftCardModel], Error>) in
            switch result {
            case .success(let cards):
                XCTAssertFalse(cards.isEmpty)
                expectations.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                expectations.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // check if get cards api response has expected brand or not
    func testGetCardsApiResponseHasExpectedBrand() {
        let expectedBrand = "Amazon.com.au"
        let expectations = self.expectation(description: "testGetCardsApi")
        ApiService.shared.executeRequest(withApi: ApiRepo.getCards) { (result: Result<[GiftCardModel], Error>) in
            switch result {
            case .success(let cards):
                XCTAssertTrue(cards.contains(where: { $0.brand == expectedBrand }))
                expectations.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                expectations.fulfill()
                break
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
