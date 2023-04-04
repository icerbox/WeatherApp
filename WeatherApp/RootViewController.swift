//
//  ViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

class RootViewController: UIViewController, UINavigationControllerDelegate {
    
    private let service = Service()
    
    private let tableView = UITableView()
    
    private var weatherData: ApiResponse?
    private let citiesCellIdentifier = "CitiesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        service.updateData()
        setupViews()
    }
    
    @objc func addNewCity() {
        let addCityViewController = AddCityViewController()
        present(addCityViewController, animated: true)
    }

    func setupViews() {
        title = "Список городов"
        tableView.dataSource = self
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: "citiesCellIdentifier")
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

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        return UITableViewCell()
    }
}


