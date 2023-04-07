//
//  Service.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import CoreLocation
import SVGKit

final class Service {
    
    // Ключ для доступа в API Яндекс погоды
    private var token: String = "23ab229e-2b5a-4cf7-9af1-fd1b5ddf578c"
    // Делегает основного вьюконтроллера
    weak var delegate: RootViewController?
    
    // Метод для перебора массива с названиями городов citiesNameArray
    func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, WeatherData) -> Void) {
        // берем его индекс и его название
        for (index, item) in citiesArray.enumerated() {
            // При помощи метода getCityCoordinates по его названию item, получаем его координаты
            getCityCoordinates(city: item, completion: { (coordinate, error) in
                guard let coordinate = coordinate, error == nil else { return }
                self.updateData(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                    completionHandler(index, weather)
                }
            })
        }
    }
    
    func getCityCoordinates(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
    // Метод который авторизуется в API Яндекс погоды используя token и в соответствии с полученными данными забирает данные с json в модель данных WeatherData
    func updateData(latitude: Double, longitude: Double, completionHandler: @escaping (WeatherData) -> Void) {
        // Если токен не пустой то продолжаем
        guard !token.isEmpty else {
          let requestTokenViewController = AuthViewController()
          requestTokenViewController.delegate = self
          requestTokenViewController.modalPresentationStyle = .fullScreen
            delegate?.present(requestTokenViewController, animated: false, completion: nil)
          return
        }
        // Собираем строку для ссылки
        var components = URLComponents(string: "https://api.weather.yandex.ru/v2/forecast")
        components?.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "extra", value: "true"),
        ]
        // Если ссылка сформирована продолжаем
        guard let url = components?.url else { return }
//            print("Сформирована ссылка \(url)")
        // Формируем запрос из ссылки
        var request = URLRequest(url: url)
//            print("Запрос \(request)")
        // В соответствии с документацией Яндекс API добавляем к токену значение для хидера
        request.setValue("\(token)", forHTTPHeaderField: "X-Yandex-API-Key")
        // Создаем таску
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            // Если данные получены продолжаем
            guard let data = data else {
                // Если при получении данных получена ошибка, принтим в консоль
                print(String(describing: error))
                return
            }
            do {
                // Сохраняем декодированные данные в переменную apiData
                let apiData = try JSONDecoder().decode(ApiResponse.self, from: data)
                // Если полученные данные соответствуют модели WeatherData продолжаем
                guard let weather = WeatherData(apiResponse: apiData) else { return }
                // Передаем данные в модель WeatherData
                completionHandler(weather)
            }
            // Ловим ошибку
            catch let jsonError as NSError {
                print("Failed to decode with error: \(jsonError.localizedDescription)")
            }
        }
        // запускам таску
        task.resume()
    }
}

extension Service: AuthViewControllerDelegate {
  func handleTokenChanged(token: String) {
    self.token = token
  }
}
