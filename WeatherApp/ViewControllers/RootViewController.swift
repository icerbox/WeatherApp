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
        // Если массив citiesArray пустой, то заполняем пустыми значениями в соответствии с количеством элементов в citiesNameArray
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: defaultCity, count: citiesNameArray.count)
        }
        addCities()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Если это первый запуск, то обновляем данные о погоде
        if isFirst {
//            service.updateData()
        }
        isFirst = false
    }
    // Метод который вызывается при нажатии на кнопку "+" для добавления нового города в главный список
    @objc func addNewCity() {
        let addCityViewController = AddCityViewController()
        addCityViewController.delegate = self
        show(addCityViewController, sender: self)
    }
    
    func addCities() {
        service.getCityWeather(citiesArray: self.citiesNameArray) { (index, weather) in
            citiesArray[index] = weather
            citiesArray[index].name = self.citiesNameArray[index]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupViews() {
        title = "Прогноз погоды"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitiesListTableViewCell.self, forCellReuseIdentifier: citiesCellIdentifier)
        tableView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 200
        view.addSubview(tableView)
    }
        
    func setupConstraints() {
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
        // Создаем экземпляр детального вьюконтроллера
        let detailViewController = DetailViewController()
        
        detailViewController.selectedCity = citiesArray[indexPath.row]
        show(detailViewController, sender: self)
    }
}

extension UIView {
    // Метод для закрашивания ячеек в градиент
    func addGradient(colors: [UIColor] = [.blue, .white], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial) {
        let gradient = CAGradientLayer()
        
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
}
