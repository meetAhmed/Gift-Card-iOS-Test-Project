//
//  GiftCardPurchasedVC.swift
//  Gift Card
//

import UIKit

class GiftCardPurchasedVC: BaseVC {
    
    var interactor: GiftCardPurchasedSceneBusinessLogic?
    
    var listOfCards = [GiftCardModel]()
    
    // thank you label
    let thankYouLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Thank you for your purchase!"
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontLargeSize)
        return label
    }()
    
    // thank you view, which holds thank you label
    let thankYouView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.lightGrayColor.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // tableview
    let tableView: UITableView = {
        let table = UITableView()
        table.register(GiftCardPurchasedCell.self, forCellReuseIdentifier: GiftCardPurchasedCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension GiftCardPurchasedVC {
    
    func setupUI() {
        view.backgroundColor = .white
        title = "Purchased"
        addSubViewsAndlayout()
        if let cards = interactor?.cards {
            listOfCards.append(contentsOf: cards)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        // since user is here, so remove items from cart, which user has already purchased 
        listOfCards.forEach {
            if CartManager.shared.isCardAlreadyAdded($0) {
                CartManager.shared.removeFromCart($0)
            }
        }
    }
    
    func addSubViewsAndlayout() {
        view.addSubview(thankYouView)
        view.addSubview(tableView)
        thankYouView.addSubview(thankYouLabel)
       
        NSLayoutConstraint.activate([
            thankYouView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            thankYouView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: thankYouView.bottomAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            thankYouLabel.topAnchor.constraint(equalTo: thankYouView.topAnchor, constant: 10),
            thankYouLabel.leadingAnchor.constraint(equalTo: thankYouView.leadingAnchor, constant: 10),
            thankYouLabel.trailingAnchor.constraint(equalTo: thankYouView.trailingAnchor, constant: -10),
            thankYouLabel.bottomAnchor.constraint(equalTo: thankYouView.bottomAnchor, constant: -10),
        ])
    }
}

extension GiftCardPurchasedVC: GiftCardPurchasedSceneDisplayView {}

extension GiftCardPurchasedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        GiftCardPurchasedCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GiftCardPurchasedCell = tableView.dequeueReusableCell(withIdentifier: GiftCardPurchasedCell.identifier, for: indexPath) as! GiftCardPurchasedCell
        cell.cardModel = listOfCards[indexPath.row]
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .white
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
