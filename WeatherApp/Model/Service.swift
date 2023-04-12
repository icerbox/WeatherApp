//
//  Service.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import CoreLocation
import SVGKit
import UIKit

final class Service {
    
    // Ключ для доступа в API Яндекс погоды
    private var token: String = "23ab229e-2b5a-4cf7-9af1-fd1b5ddf578c"
    
    // Делегает основного вьюконтроллера
    weak var delegate: RootViewController?
    // Объявляем индикатор загрузки
    let activityIndicator = UIActivityIndicatorView()
    
    // Метод для перебора массива с названиями городов citiesNameArray
    func getCityWeather(citiesArray: [String], completionHandler: @escaping (Int, WeatherData) -> Void) {
        // берем его индекс и его название
        for (index, item) in citiesArray.enumerated() {
            // При помощи метода getCityCoordinates по его названию item, получаем его координаты
            getCityCoordinates(city: item, completion: { (coordinate, error) in
                guard let coordinate = coordinate, error == nil else { return }
                // при помощи метода updateData скачиваем данные по полученным координатам
                self.updateData(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                    // Полученные данные при помощи замыкания передаем в модель данных WeatherData
                    completionHandler(index, weather)
                }
            })
        }
    }
    
    // Метод который при помощи CoreLocation, получает долготу и широту по названию города из переменной city
    func getCityCoordinates(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
    
    // Метод который авторизуется в API Яндекс погоды используя token и в соответствии с полученными данными забирает данные с json в модель данных WeatherData
    func updateData(latitude: Double, longitude: Double, completionHandler: @escaping (WeatherData) -> Void) {
        // Если токен не пустой то продолжаем
        guard !token.isEmpty else {
            print("Token пустой")
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
        print(url)
        // Формируем запрос из ссылки
        var request = URLRequest(url: url)
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
    
    // Метод для загрузки иконки погодных условий
    func loadIcon(viewModel: WeatherData, imageViewToSet: UIImageView) {
        // Добавляем переменную которая будет хранить полученную иконку
        var receivedImage = SVGKImage()
        // В фоновом режиме начинаем качать иконку
        DispatchQueue.global(qos: .background).async {
            // Создаем переменную svgURL для хранения ссылки для текущей иконки. Ссылка получается из conditionCod'a текущего элемента
            let svgUrl = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(viewModel.conditionCode).svg")!
            // Пробуем скачать svg по ссылке из svgUrl
            let image = try? Data(contentsOf: svgUrl)
            
            // Сохраняем полученную картинку в receivedImage
            receivedImage = SVGKImage(data: image)
            // Выводим скачанную иконку в главный поток и прикрепляем к ImageView
            DispatchQueue.main.async {
                imageViewToSet.image = receivedImage.uiImage
            }
        }
    }
    
    // Метод для конвертации даты и времени полученного в формате UnixTime
    func convertTime(timeToConvert: Double) -> String {
        let date = Date(timeIntervalSince1970: timeToConvert)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    // Метод для изменения иконки направления ветра в зависимости от полученного значения
    func changeWindIcon(windDirection: String) -> UIImage {
        switch windDirection {
        case "с/з": return UIImage(systemName: "arrow.down.forward")!
        case "с": return UIImage(systemName: "arrow.down")!
        case "с/в": return UIImage(systemName: "arrow.down.left")!
        case "в": return UIImage(systemName: "arrow.left")!
        case "ю/в": return UIImage(systemName: "arrow.up.right")!
        case "ю": return UIImage(systemName: "arrow.up.left")!
        case "ю/з": return UIImage(systemName: "arrow.right")!
        case "з": return UIImage(systemName: "arrow.up.forward")!
        default: return UIImage(systemName: "xmark")!
        }
    }
}
