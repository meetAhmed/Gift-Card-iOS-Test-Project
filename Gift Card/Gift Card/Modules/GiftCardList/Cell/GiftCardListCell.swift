//
//  GiftCardListCell.swift
//  Gift Card
//
//

import UIKit

class GiftCardListCell: UITableViewCell {
    
    static let identifier = "GiftCardListCell"
    static let cellHeight = 120.0
    
    // thumbanail image view
    let thumbanail: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // arrow to show on right side as detail button
    let rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")!
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // brand label view
    let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontLargeSize)
        return label
    }()
    
    // discount label view
    let discountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontMediumSize)
        return label
    }()
    
    // vendor label view
    let vendorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontMediumSize)
        return label
    }()
 
    // vertical stack which holds brand, discount and vendor
    let vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.alignment = .leading
        view.spacing = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainView: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // card model
    // when model is set, update labels
    var cardModel: GiftCardModel? {
        didSet {
            if let card = cardModel {
                brandLabel.text = card.brand
                discountLabel.text = "Discount: \(card.discount)"
                vendorLabel.text = card.vendor
                thumbanail.loadImage(withUrl: card.image)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViewsAndlayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GiftCardListCell {
    
    func addSubViewsAndlayout() {
        contentView.addSubview(mainView)
        mainView.addSubview(thumbanail)
        mainView.addSubview(brandLabel)
        mainView.addSubview(discountLabel)
        mainView.addSubview(vendorLabel)
        mainView.addSubview(vStack)
        mainView.addSubview(rightArrow)
        vStack.addArrangedSubview(brandLabel)
        vStack.addArrangedSubview(discountLabel)
        vStack.addArrangedSubview(vendorLabel)
        
        let screenWidth = contentView.frame.size.width
        
        // setup constraints
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            thumbanail.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            thumbanail.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            thumbanail.heightAnchor.constraint(equalTo: mainView.heightAnchor),
            thumbanail.widthAnchor.constraint(equalToConstant: screenWidth - (screenWidth * 0.7)),
            vStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: thumbanail.trailingAnchor, constant: 15),
            vStack.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -15),
            rightArrow.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            rightArrow.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            rightArrow.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // set background color, make corners round
        mainView.layer.backgroundColor = Constants.lightGrayColor.cgColor
        mainView.layer.cornerRadius = 10
        thumbanail.layer.cornerRadius = 10
        thumbanail.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        thumbanail.clipsToBounds = true
        thumbanail.contentMode = .scaleToFill
    }
}
