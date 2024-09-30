//
//  CartItemCell.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import UIKit

protocol CartItemCellDelegate: AnyObject {
    func cartItemCell(_ cell: CartItemCell, didTapAddFor shoe: Shoe)
    func cartItemCell(_ cell: CartItemCell, didTapRemoveFor shoe: Shoe)
}

class CartItemCell: UITableViewCell {
    static let identifier = "CartItemCell"

    weak var delegate: CartItemCellDelegate?
    private var shoe: Shoe?

    private let shoeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGreen
        return label
    }()

    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(shoeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)

        shoeImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shoeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shoeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            shoeImageView.widthAnchor.constraint(equalToConstant: 80),
            shoeImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.leadingAnchor.constraint(equalTo: shoeImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            removeButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            removeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            removeButton.widthAnchor.constraint(equalToConstant: 44),
            removeButton.heightAnchor.constraint(equalToConstant: 44),

            quantityLabel.leadingAnchor.constraint(equalTo: removeButton.trailingAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: removeButton.centerYAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 44),

            addButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor),
            addButton.centerYAnchor.constraint(equalTo: removeButton.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configure(with shoe: Shoe, quantity: Int) {
        self.shoe = shoe
        nameLabel.text = shoe.name
        priceLabel.text = String(format: "Rp %.2f", shoe.price)
        quantityLabel.text = "\(quantity)"

        // Untuk sementara, kita akan menggunakan placeholder image
        shoeImageView.image = UIImage(systemName: "shoe")
    }

    @objc private func addButtonTapped() {
        guard let shoe = shoe else { return }
        delegate?.cartItemCell(self, didTapAddFor: shoe)
    }

    @objc private func removeButtonTapped() {
        guard let shoe = shoe else { return }
        delegate?.cartItemCell(self, didTapRemoveFor: shoe)
    }
}
