//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 06.04.2023.
//

import UIKit

class DetailViewController: UIViewController,  UINavigationControllerDelegate {
    
    // Переменная куда будут передаваться данные кликнутой ячейки
    var selectedCity: WeatherData?
    
    private let tableView = UITableView()
    private let detailCellIdentifier = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        title = "Подробный прогноз погоды"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifier)
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = view.bounds.height * 0.9
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
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
        // Вызываем метод configure из кастомной ячейки DetailTableViewCell
        cell.configure(currentCity)
        return cell
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.contentView.addGradient(colors: [.systemBlue, .cyan])
        cell.layer.mask = maskLayer
    }

}
