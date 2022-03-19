//
//  GiftCardCartVC.swift
//  Gift Card
//
//

import UIKit
import DZNEmptyDataSet
import ToastViewSwift

class GiftCardCartVC: BaseVC {
    
    var router: GiftCardCartSceneRoutingLogic?
    
    var listOfCards = [GiftCardModel]()
    
    // table view
    let tableView: UITableView = {
        let table = UITableView()
        table.register(GiftCardCartCell.self, forCellReuseIdentifier: GiftCardCartCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // horizontal stack which holds clear cart and buy now buttons
    let hStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clearCartButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.appColor
        view.layer.cornerRadius = 10
        view.setTitle("Clear Cart", for: .normal)
        view.addTarget(self, action: #selector(clearCartButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buyNowButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.appColor
        view.layer.cornerRadius = 10
        view.setTitle("Buy Now", for: .normal)
        view.addTarget(self, action: #selector(buyNowButtonClicked(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listOfCards.removeAll()
        listOfCards.append(contentsOf: CartManager.shared.cards)
        tableView.reloadData()
        
        hStack.isHidden = listOfCards.isEmpty
    }
}

extension GiftCardCartVC {
    
    func setupUI() {
        view.backgroundColor = .white
        title = "Cart"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        addSubViewsAndlayout()
    }
    
    func addSubViewsAndlayout() {
        view.addSubview(tableView)
        view.addSubview(hStack)
        hStack.addArrangedSubview(clearCartButton)
        hStack.addArrangedSubview(buyNowButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hStack.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 15),
            hStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            hStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            hStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}

extension GiftCardCartVC: GiftCardCartSceneDisplayView { }

extension GiftCardCartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        GiftCardCartCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GiftCardCartCell = tableView.dequeueReusableCell(withIdentifier: GiftCardCartCell.identifier, for: indexPath) as! GiftCardCartCell
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

extension GiftCardCartVC {
    
    @objc func clearCartButton(_ sender: Any) {
        if !CartManager.shared.cards.isEmpty {
            CartManager.shared.clearCart()
            Toast.default(
                image: UIImage(systemName: "cart.badge.minus")!,
                title: "Cart is cleared successfully"
            ).show()
            listOfCards.removeAll()
            tableView.reloadData()
            hStack.isHidden = listOfCards.isEmpty
        }
    }
    
    @objc func buyNowButtonClicked(_ sender: Any) {
        if !CartManager.shared.cards.isEmpty {
            router?.routeToPurchaseView(with: CartManager.shared.cards)
        }
    }
}

extension GiftCardCartVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        NSAttributedString(string: "No item in cart")
    }
}
