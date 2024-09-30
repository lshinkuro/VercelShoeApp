//
//  ShoeDetailViewController.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import UIKit

class ShoeDetailViewController: UIViewController {

    private let shoe: Shoe
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let addToCartButton = UIButton()

    init(shoe: Shoe) {
        self.shoe = shoe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = shoe.name

        nameLabel.text = shoe.name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)

        priceLabel.text = String(format: "Rp %.2f", shoe.price)
        priceLabel.font = UIFont.systemFont(ofSize: 18)

        addToCartButton.setTitle("Tambah ke Keranjang", for: .normal)
        addToCartButton.backgroundColor = .systemBlue
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.layer.cornerRadius = 8
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)

        [nameLabel, priceLabel, addToCartButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addToCartButton.widthAnchor.constraint(equalToConstant: 200),
            addToCartButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func addToCartTapped() {
        CartService.shared.addToCart(shoe: shoe)
        let alert = UIAlertController(title: "Berhasil", message: "\(shoe.name) telah ditambahkan ke keranjang", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
