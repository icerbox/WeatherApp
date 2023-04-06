//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 06.04.2023.
//

import UIKit

class DetailViewController: UIViewController,  UINavigationControllerDelegate {
    
    var selectedCity: WeatherData?
    
    private let tableView = UITableView()
    private let detailCellIdentifier = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func refreshLabels() {
        
    }
    
    func setupViews() {
        title = "Подробный прогноз погоды"
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.backgroundColor = .yellow
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as! DetailTableViewCell
        // Если кликнутый город имеет значение, продолжаем
        guard let currentCity = selectedCity else { return UITableViewCell() }
        cell.configure(currentCity)
        return cell
    }
}
