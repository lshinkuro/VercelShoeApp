//
//  DashboardViewController.swift
//  VercelMarketApp
//
//  Created by Macbook on 22/09/24.
//

import UIKit

class DashboardViewController: UIViewController {

  private let tableView = UITableView()
  private var shoes: [Shoe] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    loadShoes()
  }

  private func setupUI() {
    view.backgroundColor = .white
    title = "Sepatu"

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ShoeTableViewCell.self, forCellReuseIdentifier: ShoeTableViewCell.identifier)
    tableView.separatorStyle = .none

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }

  private func loadShoes() {
    // Simulasi data sepatu
    shoes = [
      Shoe(id: 1, name: "Nike Air Max", price: 1500000, imageURL: "https://example.com/nikeairmax.jpg"),
      Shoe(id: 2, name: "Adidas Ultraboost", price: 2000000, imageURL: "https://example.com/adidasultraboost.jpg"),
      Shoe(id: 3, name: "Puma RS-X", price: 1200000, imageURL: "https://example.com/pumars-x.jpg")
    ]
    tableView.reloadData()
  }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoeTableViewCell.identifier, for: indexPath) as? ShoeTableViewCell else {
      fatalError("Failed to dequeue ShoeTableViewCell")
    }
    let shoe = shoes[indexPath.row]
    cell.configure(with: shoe)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedShoe = shoes[indexPath.row]
    let detailVC = ShoeDetailViewController(shoe: selectedShoe)
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
