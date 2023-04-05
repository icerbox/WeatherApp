//
//  ViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

class RootViewController: UIViewController, UINavigationControllerDelegate {
    
    let defaultCity = WeatherData()
    
    // Массив который содержит имена городов
    let citiesNameArray = ["Якутск", "Москва", "Санкт-Петербург"]
    
    private let service = Service()
    private let tableView = UITableView()
    // Был ли это первый запуск приложения. После первого запуска во ViewDidAppear меняем на false
    private var isFirst = true
    // Переменная для json данных
    private var weatherData: ApiResponse?
    private let citiesCellIdentifier = "CitiesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        service.getCityCoordinates(city: "Якутск", completion: { (coordinate, error) in
//            print("Координаты города: \(String(describing: coordinate))")
//        })
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: defaultCity, count: citiesNameArray.count)
        }
        addCities()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Если это первый запуск, то обновляем данные о погоде
        if isFirst {
//            service.updateData()
        }
        isFirst = false
    }
    
    @objc func addNewCity() {
        let addCityViewController = AddCityViewController()
        present(addCityViewController, animated: true)
    }
    
    func addCities() {
        service.getCityWeather(citiesArray: self.citiesNameArray) { (index, weather) in
            citiesArray[index] = weather
            citiesArray[index].name = self.citiesNameArray[index]
            print(citiesArray)
        }
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: citiesCellIdentifier, for: indexPath)
//        guard let citiesForecast = WeatherData(apiResponse: ) >
        return UITableViewCell()
    }
}


