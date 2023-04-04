//
//  ViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

class RootViewController: UIViewController, UINavigationControllerDelegate {
    
    private let tableView = UITableView()
    private var token: String = "23ab229e-2b5a-4cf7-9af1-fd1b5ddf578c"
    private var weatherData: ApiResponse?
    private let citiesCellIdentifier = "CitiesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCity))
        updateData()
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
    
    private func updateData() {
        guard !token.isEmpty else {
          let requestTokenViewController = AuthViewController()
          requestTokenViewController.delegate = self
          requestTokenViewController.modalPresentationStyle = .fullScreen
          present(requestTokenViewController, animated: false, completion: nil)
          return
        }
    
        var components = URLComponents(string: "https://api.weather.yandex.ru/v2/forecast")
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "55.75396"),
            URLQueryItem(name: "lon", value: "37.620393"),
            URLQueryItem(name: "extra", value: "true"),
        ]
        guard let url = components?.url else { return }
        print("Сформирована ссылка \(url)")
        var request = URLRequest(url: url)
        print("Запрос \(request)")
        request.setValue("\(token)", forHTTPHeaderField: "X-Yandex-API-Key")
        let task = URLSession.shared.dataTask(with: request) { [weak self]
            (data, response, error) in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("data: \(jsonString)")
                }
            }
            
            guard let sself = self, let data = data else { return }
            guard let newFiles = try? JSONDecoder().decode(ApiResponse.self, from: data) else { return }
            print("Начинаем обрабатывать файлы \(newFiles)")
            print("Received: \(newFiles.cities?.count ?? 0) files")
            sself.weatherData = newFiles
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: citiesCellIdentifier, for: indexPath)
        guard let items = weatherData?.cities, items.count > indexPath.row else {
            return cell
        }
        let currentFile = items[indexPath.row]
        return cell
    }
}

extension RootViewController: AuthViewControllerDelegate {
  func handleTokenChanged(token: String) {
    self.token = token
    print("New token: \(token)")
    updateData()
  }
}
