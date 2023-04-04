//
//  Service.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation

final class Service {
    
    private var token: String = "23ab229e-2b5a-4cf7-9af1-fd1b5ddf578c"
    
    weak var delegate: RootViewController?
    
    func updateData() {
        guard !token.isEmpty else {
          let requestTokenViewController = AuthViewController()
          requestTokenViewController.delegate = self
          requestTokenViewController.modalPresentationStyle = .fullScreen
            delegate?.present(requestTokenViewController, animated: false, completion: nil)
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
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("data: \(jsonString)")
                }
            }
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let apiData = try JSONDecoder().decode(ApiResponse.self, from: data)
                guard let weather = WeatherData(apiResponse: apiData) else { return }
                print(weather)
            }
            catch let jsonError as NSError {
                print("Failed to decode with error: \(jsonError.localizedDescription)")
            }
        }
        task.resume()
    }
}

extension Service: AuthViewControllerDelegate {
  func handleTokenChanged(token: String) {
    self.token = token
    print("New token: \(token)")
    updateData()
  }
}
