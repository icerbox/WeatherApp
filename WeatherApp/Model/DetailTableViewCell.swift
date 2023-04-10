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
//        image.backgroundColor = .green
        image.contentMode = .scaleAspectFit
        return image
    }()
     
    // Имэджвью для вывода иконки давления
    lazy var pressureIcon = {
        var image = UIImageView(image: UIImage(systemName: "thermometer.high"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Имэджвью для вывода иконки давления
    lazy var windIcon = {
        var image = UIImageView(image: UIImage(systemName: "wind"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для погодных условий
    private lazy var weatherCondition: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для текущей температуры
    private lazy var weatherTemperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-bold", size: 60)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для давления воздуха
    private lazy var weatherPressure: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для скорости ветра
    private lazy var windSpeed: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для минимальной температуры
    private lazy var minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для максимальной температуры
    private lazy var maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textAlignment = .center
        return label
    }()
    
    // Лейбл для минимальной + максимальной температуры
    private lazy var averageTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var upperStackView: UIStackView = {
        let stackView = UIStackView()
        // stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(cityName)
        return stackView
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFit
        stackView.distribution = .equalCentering
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(conditionIcon)
        stackView.addArrangedSubview(middleRightStackView)
        return stackView
    }()
    
    private lazy var middleRightStackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .orange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(weatherTemperature)
        stackView.addArrangedSubview(averageTemp)
        stackView.addArrangedSubview(weatherCondition)
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        // stackView.backgroundColor = .blue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(pressureStackView)
        stackView.addArrangedSubview(windSpeedStackView)
        return stackView
    }()
    
    private lazy var pressureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(weatherPressure)
        stackView.addArrangedSubview(pressureIcon)
        return stackView
    }()
    
    private lazy var windSpeedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(windSpeed)
        stackView.addArrangedSubview(windIcon)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upperStackView)
        contentView.addSubview(middleStackView)
        contentView.addSubview(bottomStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        weatherTemperature.text = "\(String(describing: viewModel.temperatureString))ºС"
        weatherPressure.text = "\(String(describing: viewModel.pressureMm))"
        windSpeed.text = "\(String(describing: viewModel.windSpeed))"
        minTemp.text = "\(String(describing: viewModel.tempMin))º"
        maxTemp.text = "\(String(describing: viewModel.tempMax))º"
        averageTemp.text = "\(viewModel.tempMin)º / \(viewModel.tempMax)º"
    }
    
    // Устанавливаем констрейнты
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Стеквью для названия города
            upperStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upperStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upperStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            upperStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
            // Стеквью для иконки, температуры и погодны условий
            middleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            middleStackView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor),
            middleStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            // Констрейнты для иконки
            conditionIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            conditionIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            pressureIcon.widthAnchor.constraint(equalToConstant: 30),
            pressureIcon.heightAnchor.constraint(equalToConstant: 30),
            
            windIcon.widthAnchor.constraint(equalToConstant: 30),
            windIcon.heightAnchor.constraint(equalToConstant: 30),
            
            // Стеквью для давления воздуха, скорости ветра, минимальной и максимальной температуры
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
