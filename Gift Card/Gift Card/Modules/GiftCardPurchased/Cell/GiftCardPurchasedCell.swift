//
//  GiftCardListCell.swift
//  Gift Card
//
//

import UIKit

class GiftCardPurchasedCell: UITableViewCell {
    
    static let identifier = "GiftCardPurchasedCell"
    static let cellHeight = 90.0
    
    // thumbnail image view
    let thumbanail: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // brand label
    let brandLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontLargeSize)
        return label
    }()
    
    // vendor label
    let vendorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: Constants.fontMediumSize)
        return label
    }()
    
    // line view, separator between cells
    let lineView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = Constants.lightGrayColor.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cardModel: GiftCardModel? {
        didSet {
            if let card = cardModel {
                brandLabel.text = card.brand
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

extension GiftCardPurchasedCell {
    
    func addSubViewsAndlayout() {
        
        contentView.addSubview(thumbanail)
        contentView.addSubview(brandLabel)
        contentView.addSubview(vendorLabel)
        contentView.addSubview(lineView)
        
        let screenWidth = contentView.frame.size.width
        
        // setup constraints
        NSLayoutConstraint.activate([
            thumbanail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbanail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            thumbanail.heightAnchor.constraint(equalToConstant: 80),
            thumbanail.widthAnchor.constraint(equalToConstant: screenWidth - (screenWidth * 0.7)),
            brandLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            brandLabel.leadingAnchor.constraint(equalTo: thumbanail.trailingAnchor, constant: 15),
            brandLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            vendorLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor),
            vendorLabel.leadingAnchor.constraint(equalTo: brandLabel.leadingAnchor),
            vendorLabel.trailingAnchor.constraint(equalTo: brandLabel.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: thumbanail.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}
