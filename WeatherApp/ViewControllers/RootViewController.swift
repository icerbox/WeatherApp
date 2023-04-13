//
//  ViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

final class RootViewController: UIViewController, UINavigationControllerDelegate, CityAppender {
    
    // Метод который вызывается из AddCityViewController при нажатии на кнопку "Cancel"
    func cancelButtonTap(_ controller: AddCityViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    // Метод который вызываетс из AddCityViewController при нажатии на кнопку "Done"
    func doneButtonTap(_ controller: AddCityViewController, didFinishAdding item: String) {
        citiesNameArray.append(item)
        citiesArray.append(defaultCity)
        addCities()
    }
    
    // Переменная поменяется на true, после загрузки данных
    private var isDataLoaded = false
    
    // Город по умолчанию для заполнения данных на случай если citiesArray будет пуст
    private let defaultCity = WeatherData()
    
    // Массив который содержит имена городов
    private var citiesNameArray = ["Якутск", "Москва", "Санкт-Петербург"]
    
    private let service = Service()
    
    private let tableView = UITableView()
    // Переменная для json данных
    private var weatherData: ApiResponse?
    // Идентификатор кастомной ячейки
    private let citiesCellIdentifier = "CitiesListTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Кнопка для добавления нового города
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        
        // Кнопка для обновления основной таблицы
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateTable))
        
        // Если массив citiesArray пустой, то заполняем пустыми значениями в соответствии с количеством элементов в citiesNameArray
        fillCitiesArray()
        addCities()
        setupViews()
        setupConstraints()
    }
    
    // Метод который вызывается при нажатии на кнопку "+" для добавления нового города в главный список
    @objc
    private func addNewCity() {
        let addCityViewController = AddCityViewController()
        addCityViewController.delegate = self
        show(addCityViewController, sender: self)
    }
    
    
    private func addCities() {
        service.getCityWeather(citiesArray: self.citiesNameArray) { (index, weather) in
            citiesArray[index] = weather
            citiesArray[index].name = self.citiesNameArray[index]
            self.updateTable(changeDataLoadedTo: true)
        }
    }
    
    private func fillCitiesArray() {
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: defaultCity, count: citiesNameArray.count)
        }
    }
    
    @objc
    private func updateTable(changeDataLoadedTo: Bool) {
        DispatchQueue.main.async {
            self.isDataLoaded = changeDataLoadedTo
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        title = "Прогноз погоды"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: citiesCellIdentifier)
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

// MARK: - UITableViewDataSource

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: citiesCellIdentifier, for: indexPath) as! CitiesListTableViewCell
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = ViewMetrics.cornerRadius
        var weather = WeatherData()
            weather = citiesArray[indexPath.row]
        cell.configure(weather)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = ViewMetrics.cornerRadius
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
}

// MARK: - UITableViewDelegate

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {
            (contextualAction: UIContextualAction, swipeButton: UIView, completionHandler: (Bool) -> Void) in
            citiesArray.remove(at: indexPath.row)
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
            completionHandler(true)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    // При клике на ячейку:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isDataLoaded {
            // Создаем экземпляр детального вьюконтроллера
            let detailViewController = DetailViewController()
            
            detailViewController.selectedCity = citiesArray[indexPath.row]
            show(detailViewController, sender: self)
        } 
    }
    // Задаем высоту ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
}

