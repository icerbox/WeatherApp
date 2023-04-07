//
//  ViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

class RootViewController: UIViewController, UINavigationControllerDelegate, AddCityViewControllerDelegate {
    
    func addCityViewControllerDidCancel(_ controller: AddCityViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addCityViewController(_ controller: AddCityViewController, didFinishAdding item: String) {
        citiesNameArray.append(item)
        citiesArray.append(defaultCity)
        addCities()
    }
    
    
    let defaultCity = WeatherData()
    
    // Массив который содержит имена городов
    var citiesNameArray = ["Якутск", "Москва", "Санкт-Петербург"]
    
    private let service = Service()
    private let tableView = UITableView()
    // Был ли это первый запуск приложения. После первого запуска во ViewDidAppear меняем на false
    private var isFirst = true
    // Переменная для json данных
    private var weatherData: ApiResponse?
    private let citiesCellIdentifier = "CitiesListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        
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
        addCityViewController.delegate = self
        show(addCityViewController, sender: self)
    }
    
    func addCities() {
        service.getCityWeather(citiesArray: self.citiesNameArray) { (index, weather) in
            print("weather: \(weather)")
            citiesArray[index] = weather
            citiesArray[index].name = self.citiesNameArray[index]
            DispatchQueue.main.async {
                print("Обновляем страницу")
                self.tableView.reloadData()
            }
        }
    }
    

    func setupViews() {
        title = "Список городов"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: citiesCellIdentifier)
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
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: citiesCellIdentifier, for: indexPath) as! CitiesListTableViewCell
        var weather = WeatherData()
        weather = citiesArray[indexPath.row]
        cell.configure(weather)
        return cell
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {
            (contextualAction: UIContextualAction, swipeButton: UIView, completionHandler: (Bool) -> Void) in
            citiesArray.remove(at: indexPath.row)
            print("Удаляем строку")
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
            completionHandler(true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    // При клике на ячейку:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Создаем экземпляр детального вьюконтроллера
        let detailViewController = DetailViewController()
        
        detailViewController.selectedCity = citiesArray[indexPath.row]
        show(detailViewController, sender: self)
    }
}


