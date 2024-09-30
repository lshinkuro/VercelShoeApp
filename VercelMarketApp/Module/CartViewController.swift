//
//  CartViewController.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import UIKit

class CartViewController: UIViewController {

  private let tableView = UITableView()

  private let totalPriceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.textAlignment = .right
    label.text = "Total: Rp 0"
    return label
  }()

  private let emptyStateView: EmptyStateView = {
    let view = EmptyStateView()
    view.isHidden = true // Initially hidden
    return view
  }()


  private var cartItems: [(shoe: Shoe, quantity: Int)] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadCartItems()
  }

  private func setupUI() {
    view.backgroundColor = .white
    title = "Keranjang"

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.identifier)

    view.addSubview(tableView)
    view.addSubview(totalPriceLabel)
    view.addSubview(emptyStateView)

    tableView.translatesAutoresizingMaskIntoConstraints = false
    totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
    emptyStateView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor),

      totalPriceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
      totalPriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
      totalPriceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
      totalPriceLabel.heightAnchor.constraint(equalToConstant: 44),
      
      emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      emptyStateView.leftAnchor.constraint(equalTo: view.leftAnchor),
      emptyStateView.rightAnchor.constraint(equalTo: view.rightAnchor),
      emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])


  }

  private func loadCartItems() {
    cartItems = CartService.shared.getCartItems()
    tableView.reloadData()
    updateTotalPrice()
    updateEmptyStateView()
  }

  private func updateTotalPrice() {
    let total = cartItems.reduce(0) { $0 + $1.shoe.price * Double($1.quantity) }
    totalPriceLabel.text = String(format: "Total: Rp %.2f", total)
    updateEmptyStateView()
  }

  private func updateEmptyStateView() {
      emptyStateView.isHidden = !cartItems.isEmpty
      tableView.isHidden = cartItems.isEmpty
      totalPriceLabel.isHidden = cartItems.isEmpty
  }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cartItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier, for: indexPath) as? CartItemCell else {
      fatalError("Failed to dequeue CartItemCell")
    }
    let item = cartItems[indexPath.row]
    cell.configure(with: item.shoe, quantity: item.quantity)
    cell.delegate = self
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

extension CartViewController: CartItemCellDelegate {
  func cartItemCell(_ cell: CartItemCell, didTapAddFor shoe: Shoe) {
    CartService.shared.addToCart(shoe: shoe)
    loadCartItems()
    loadCartItems()
  }

  func cartItemCell(_ cell: CartItemCell, didTapRemoveFor shoe: Shoe) {
    CartService.shared.removeFromCart(shoe: shoe)
    loadCartItems()
    loadCartItems()
  }
}
