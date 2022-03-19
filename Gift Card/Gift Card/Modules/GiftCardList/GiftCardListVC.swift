//
//  GiftCardListVC.swift
//  Gift Card
//
//

import UIKit

class GiftCardListVC: BaseVC {
    
    var interactor: GiftCardSceneBusinessLogic?
    var router: GiftCardSceneRoutingLogic?
    
    var listOfCards = [GiftCardModel]()
    
    // table view
    let tableView: UITableView = {
       let table = UITableView()
        table.register(GiftCardListCell.self, forCellReuseIdentifier: GiftCardListCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // show loader, since we will call get cards api
        showLoader()
        setupUI()
        interactor?.getCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // add cart item on right side
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"),
                                                                                 style: .plain,
                                                                                 target: self,
                                                                                 action: #selector(didTapCart))
    }
}

extension GiftCardListVC {
    
    // set title, background color for view
    func setupUI() {
        view.backgroundColor = .white
        title = "Gift Cards"
        addSubViewsAndlayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // set constraints for table view
    func addSubViewsAndlayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension GiftCardListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        GiftCardListCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // de-queue cell, provide card to it
        // remove selected background default color
        let cell: GiftCardListCell = tableView.dequeueReusableCell(withIdentifier: GiftCardListCell.identifier, for: indexPath) as! GiftCardListCell
        cell.cardModel = listOfCards[indexPath.row]
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .white
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // user has clicked on any card, move to details page
        router?.routeToDetails(with: listOfCards[indexPath.row])
    }
}

extension GiftCardListVC: GiftCardDisplayView {
    
    // cards received
    func didGetCards(cards: [GiftCardModel]) {
        dismissLoader()
        listOfCards.removeAll()
        listOfCards.append(contentsOf: cards)
        tableView.reloadData()
    }
    
    // error while loading card
    func failedToGetCards(message: String) {
        dismissLoader()
        showAlert(title: "Failure", message: message)
    }
}

extension GiftCardListVC {
    
    // user clicked on cart item, move to cart page
    @objc func didTapCart() {
        router?.routeToCart()
    }
}
