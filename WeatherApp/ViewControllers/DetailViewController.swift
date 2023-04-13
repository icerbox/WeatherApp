//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 06.04.2023.
//

import UIKit

final class DetailViewController: UIViewController,  UINavigationControllerDelegate {
    
    // Переменная куда будут передаваться данные кликнутой ячейки
    var selectedCity: WeatherData?
    
    private let tableView = UITableView()
    private let detailCellIdentifier = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        title = "Подробный прогноз погоды"
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = view.bounds.height * 0.9
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}

// MARK: - TableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as! DetailTableViewCell
        // Если кликнутый город имеет значение, продолжаем
        guard let currentCity = selectedCity else {
            return UITableViewCell()
        }
        // Делаем ячейку не кликабельной
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        // Вызываем метод configure из кастомной ячейки DetailTableViewCell
        cell.configure(currentCity)
        return cell
    }
}
