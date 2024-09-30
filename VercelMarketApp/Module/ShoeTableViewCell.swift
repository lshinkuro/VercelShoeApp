//
//  ShoeTableViewCell.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import UIKit

class ShoeTableViewCell: UITableViewCell {
    static let identifier = "ShoeTableViewCell"

    private let shoeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray6
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 4
        imageView.layer.masksToBounds = false // Untuk memastikan bayangan tidak terpotong
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label // Menyesuaikan dengan tema dark/light mode
        label.numberOfLines = 1
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGreen
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(shoeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)

        shoeImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shoeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shoeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shoeImageView.widthAnchor.constraint(equalToConstant: 70),
            shoeImageView.heightAnchor.constraint(equalToConstant: 70),
            shoeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            shoeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),



            nameLabel.leadingAnchor.constraint(equalTo: shoeImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

        ])
    }

    func configure(with shoe: Shoe) {
        nameLabel.text = shoe.name
        priceLabel.text = String(format: "Rp %.2f", shoe.price)
        shoeImageView.image = UIImage(systemName: "shoe")
    }
}
