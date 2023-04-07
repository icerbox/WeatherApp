//
//  DetailTableViewCell.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 06.04.2023.
//

import UIKit
import SVGKit

final class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    // Имэджвью для вывода иконки
    
    lazy var conditionIcon = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для погодных условий
    private lazy var weatherCondition: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для текущей температуры
    private lazy var weatherTemperature: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для давления воздуха
    private lazy var weatherPressure: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для скорости ветра
    private lazy var windSpeed: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для минимальной температуры
    private lazy var minTemp: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для максимальной температуры
    private lazy var maxTemp: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
//        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
//        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(conditionIcon)
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(weatherCondition)
        stackView.addArrangedSubview(weatherTemperature)
        stackView.addArrangedSubview(weatherPressure)
        stackView.addArrangedSubview(windSpeed)
        stackView.addArrangedSubview(minTemp)
        stackView.addArrangedSubview(maxTemp)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    typealias Completion = (Result<UIImage, Error>) -> Void
    
    func loadIcon(_ viewModel: WeatherData, completion: @escaping Completion) {
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(viewModel.conditionCode).svg")
        guard let url = url else { return }
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                guard response.statusCode == 200 else {
                    completion(.failure(URLError(.badServerResponse)))
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    completion(.failure(URLError(.cannotDecodeContentData)))
                    return
                }
                completion(.success(image))
            }
        )
        task.resume()
    }
    
    func configure(_ viewModel: WeatherData) {
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
                self.conditionIcon.image = receivedImage.uiImage
            }
        }
        
        // Назначаем остальные данные
        cityName.text = viewModel.name
        weatherCondition.text = viewModel.conditionString
        weatherTemperature.text = "\(String(describing: viewModel.temperatureString))"
        weatherPressure.text = "\(String(describing: viewModel.pressureMm))"
        windSpeed.text = "\(String(describing: viewModel.windSpeed))"
        minTemp.text = "\(String(describing: viewModel.tempMin))"
        maxTemp.text = "\(String(describing: viewModel.tempMax))"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            conditionIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            conditionIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            conditionIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}









