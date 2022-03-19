//
//  GiftCardDetailsVC.swift
//  Gift Card
//

import UIKit
import ToastViewSwift

class GiftCardDetailsVC: BaseVC {
    
    var listOfModels = [Denomination]()
    
    // scroll view
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // content view
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // thumbnail image view
    let thumbanail: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // brand view
    let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.fontLargeSize)
        return label
    }()
    
    // brand label view
    let brandSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Brand"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSmallSize)
        return label
    }()
    
    // brand view, contains both label and brand name view
    let brandView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.lightGrayColor.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // discount view, contains both discount and discount name view
    let discountView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.lightGrayColor.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // discount label view
    let discountSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Discount"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSmallSize)
        return label
    }()
    
    // discount view
    let discountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.fontLargeSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // terms view, contains both terms label and terms text view
    let termsView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.lightGrayColor.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // terms label view
    let termsSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSmallSize)
        return label
    }()
    
    // terms text view
    let termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.fontLargeSize)
        return label
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    // horizontal stack to hold add to cart and buy now button
    let hStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let addToCardButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = Constants.appColor
        view.layer.cornerRadius = 10
        view.setTitle("Add To Cart", for: .normal)
        view.addTarget(self, action: #selector(addToCardButtonClicked(_:)), for: .touchUpInside)
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
    
    var interactor: GiftCardDetailsSceneBusinessLogic?
    var router: GiftCardDetailsSceneRoutingLogic?
    
    // once model is available, update views
    var cardModel: GiftCardModel? {
        didSet {
            if let card = cardModel {
                brandLabel.text = card.brand
                discountLabel.text = "Discount: \(card.discount)"
                termsLabel.text = card.terms
                thumbanail.loadImage(withUrl: card.image)
                listOfModels.removeAll()
                listOfModels.append(contentsOf: card.denominations)
                picker.selectRow(pickerMiddleRowValue(), inComponent: 0, animated: true)
                if CartManager.shared.isCardAlreadyAdded(card) {
                    addToCardButton.setTitle("Remove From Cart", for: .normal)
                } else {
                    addToCardButton.setTitle("Add To Cart", for: .normal)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cardModel = interactor?.card
    }
}

extension GiftCardDetailsVC {
    
    func setupUI() {
        view.backgroundColor = .white
        title = interactor?.card?.brand ?? "Details"
        addSubViewsAndlayout()
        picker.delegate = self
        picker.dataSource = self
    }
    
    func addSubViewsAndlayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbanail)
        contentView.addSubview(brandView)
        contentView.addSubview(discountView)
        contentView.addSubview(termsView)
        contentView.addSubview(picker)
        contentView.addSubview(hStack)
        
        brandView.addSubview(brandLabel)
        brandView.addSubview(brandSubLabel)
        
        discountView.addSubview(discountLabel)
        discountView.addSubview(discountSubLabel)
        
        termsView.addSubview(termsLabel)
        termsView.addSubview(termsSubLabel)
        
        hStack.addArrangedSubview(addToCardButton)
        hStack.addArrangedSubview(buyNowButton)
        
        let screenHeight = self.view.frame.size.height
        
        // setup constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            thumbanail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbanail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            thumbanail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            thumbanail.heightAnchor.constraint(equalToConstant: screenHeight - (screenHeight * 0.7)),
            
            brandView.topAnchor.constraint(equalTo: thumbanail.bottomAnchor, constant: 10),
            brandView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            brandView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            discountView.topAnchor.constraint(equalTo: brandView.bottomAnchor, constant: 10),
            discountView.leadingAnchor.constraint(equalTo: brandView.leadingAnchor),
            discountView.trailingAnchor.constraint(equalTo: brandView.trailingAnchor),
            
            termsView.topAnchor.constraint(equalTo: discountView.bottomAnchor, constant: 10),
            termsView.leadingAnchor.constraint(equalTo: brandView.leadingAnchor),
            termsView.trailingAnchor.constraint(equalTo: brandView.trailingAnchor),
            
            picker.topAnchor.constraint(equalTo: termsView.bottomAnchor, constant: 10),
            picker.leadingAnchor.constraint(equalTo: brandView.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: brandView.trailingAnchor),
            
            hStack.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: brandView.leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: brandView.trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            brandSubLabel.topAnchor.constraint(equalTo: brandView.topAnchor, constant: 10),
            brandSubLabel.leadingAnchor.constraint(equalTo: brandView.leadingAnchor, constant: 10),
            brandSubLabel.trailingAnchor.constraint(equalTo: brandView.trailingAnchor, constant: -10),
            brandLabel.topAnchor.constraint(equalTo: brandSubLabel.bottomAnchor, constant: 10),
            brandLabel.leadingAnchor.constraint(equalTo: brandView.leadingAnchor, constant: 10),
            brandLabel.trailingAnchor.constraint(equalTo: brandView.trailingAnchor, constant: -10),
            brandLabel.bottomAnchor.constraint(equalTo: brandView.bottomAnchor, constant: -10),
            
            discountSubLabel.topAnchor.constraint(equalTo: discountView.topAnchor, constant: 10),
            discountSubLabel.leadingAnchor.constraint(equalTo: discountView.leadingAnchor, constant: 10),
            discountSubLabel.trailingAnchor.constraint(equalTo: discountView.trailingAnchor, constant: -10),
            discountLabel.topAnchor.constraint(equalTo: discountSubLabel.bottomAnchor, constant: 10),
            discountLabel.leadingAnchor.constraint(equalTo: discountView.leadingAnchor, constant: 10),
            discountLabel.trailingAnchor.constraint(equalTo: discountView.trailingAnchor, constant: -10),
            discountLabel.bottomAnchor.constraint(equalTo: discountView.bottomAnchor, constant: -10),
            
            termsSubLabel.topAnchor.constraint(equalTo: termsView.topAnchor, constant: 10),
            termsSubLabel.leadingAnchor.constraint(equalTo: termsView.leadingAnchor, constant: 10),
            termsSubLabel.trailingAnchor.constraint(equalTo: termsView.trailingAnchor, constant: -10),
            termsLabel.topAnchor.constraint(equalTo: termsSubLabel.bottomAnchor, constant: 10),
            termsLabel.leadingAnchor.constraint(equalTo: termsView.leadingAnchor, constant: 10),
            termsLabel.trailingAnchor.constraint(equalTo: termsView.trailingAnchor, constant: -10),
            termsLabel.bottomAnchor.constraint(equalTo: termsView.bottomAnchor, constant: -10)
        ])
    }
}

extension GiftCardDetailsVC: GiftCardDetailsSceneDisplayView { }

extension GiftCardDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        listOfModels.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(listOfModels[row].currency) \(listOfModels[row].price)"
    }
    
    func pickerMiddleRowValue() -> Int {
        if listOfModels.isEmpty {
            return 0
        } else {
            return (listOfModels.count - 1) / 2
        }
    }
}

extension GiftCardDetailsVC {
    
    @objc func addToCardButtonClicked(_ sender: Any) {
        if let card = interactor?.card {
            if CartManager.shared.isCardAlreadyAdded(card) {
                CartManager.shared.removeFromCart(card)
                addToCardButton.setTitle("Add To Cart", for: .normal)
                Toast.default(
                    image: UIImage(systemName: "cart.badge.minus")!,
                    title: "Removed from cart"
                ).show()
            } else {
                CartManager.shared.addToCart(card)
                addToCardButton.setTitle("Remove From Cart", for: .normal)
                Toast.default(
                    image: UIImage(systemName: "cart.badge.plus")!,
                    title: "Added to cart"
                ).show()
            }
        }
    }
    
    @objc func buyNowButtonClicked(_ sender: Any) {
        if let card = interactor?.card {
            router?.routeToPurchaseView(with: card)
        }
    }
}
