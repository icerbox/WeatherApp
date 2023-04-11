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
     
    // Имэджвью для вывода иконки давления
    lazy var pressureIcon = {
        var image = UIImageView(image: UIImage(systemName: "thermometer.high"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Имэджвью для вывода иконки давления
    lazy var windIcon = {
        var image = UIImageView(image: UIImage(systemName: "wind"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemBlue
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .black)
    
    // Лейбл для погодных условий
    private lazy var weatherCondition: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .white)
    
    // Лейбл для текущей температуры
    private lazy var weatherTemperature: UILabel = UILabel.makeLabel(fontName: ViewMetrics.boldFont, fontSize: ViewMetrics.headerFontSize, textColor: .white)
    
    // Лейбл для давления воздуха
    private lazy var weatherPressure: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .systemBlue)
    
    // Лейбл для скорости ветра
    private lazy var windSpeed: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .systemBlue)
    
    // Лейбл для минимальной температуры
    private lazy var minTemp: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .white)
    
    // Лейбл для максимальной температуры
    private lazy var maxTemp: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.standartFontSize, textColor: .white)
    
    // Лейбл для минимальной + максимальной температуры
    private lazy var averageTemp: UILabel = UILabel.makeLabel(fontName: ViewMetrics.standartFont, fontSize: ViewMetrics.mediumFontSize, textColor: .white)
    
    // StackView для названия города
    private lazy var upperStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [cityName])
    
    // Стеквью для иконки и middleRightStackView
    private lazy var middleStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .horizontal, contentMode: .scaleAspectFit, viewToAdd: [conditionIcon, middleRightStackView])
    
    // Стэквью для текущей температуры, средней температуры, погодных условий
    private lazy var middleRightStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [weatherTemperature, averageTemp, weatherCondition])
    
    // Стэквью для pressureStackView, windSpeedStackView
    private lazy var bottomStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .horizontal, contentMode: .scaleAspectFill, viewToAdd: [pressureStackView, windSpeedStackView])
    
    // Стэквью для давления воздуха, для иконки давления воздуха
    private lazy var pressureStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [weatherPressure, pressureIcon])
    
    // Стэквью для скорости ветра, для иконки скорости ветра
    private lazy var windSpeedStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [windSpeed, windIcon])
    
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
            upperStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            // Стеквью для иконки, температуры и погодны условий
            middleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            middleStackView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: 8),
            middleStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            // Констрейнты для иконки
            conditionIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            conditionIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            pressureIcon.widthAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            pressureIcon.heightAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            // Устанавливаем ширину для иконки
            windIcon.widthAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            windIcon.heightAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            
            // Стеквью для давления воздуха, скорости ветра, минимальной и максимальной температуры
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: 8),
            bottomStackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
