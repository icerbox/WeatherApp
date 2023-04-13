//
//  DetailTableViewCell.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 06.04.2023.
//
import SVGKit
import UIKit

final class DetailTableViewCell: UITableViewCell {
    
    static let identifier = "DetailTableViewCell"
    
    let service = Service()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upperStackView)
        contentView.addSubview(middleStackView)
        contentView.addSubview(bottomFirstStackView)
        contentView.addSubview(bottomSecondStackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: WeatherData) {
        service.loadIcon(viewModel: viewModel, imageViewToSet: self.conditionIcon)
        // Назначаем остальные данные
        cityName.text = viewModel.name
        weatherCondition.text = viewModel.conditionString
        weatherTemperature.text = "\(String(describing: viewModel.temperatureString))ºС"
        weatherPressure.text = "\(String(describing: viewModel.pressureMm)) мм"
        windSpeed.text = "\(String(describing: viewModel.windString)) м/с"
        humidity.text = "\(String(describing: viewModel.humidity))%"
        minTemp.text = "\(String(describing: viewModel.tempMin))º"
        maxTemp.text = "\(String(describing: viewModel.tempMax))º"
        averageTemp.text = "\(viewModel.tempMin)º / \(viewModel.tempMax)º"
        obsTime.text = "Погода на: \(service.convertTime(timeToConvert: viewModel.obs_time))"
        riseBegin.text = viewModel.rise_begin
        sunset.text = viewModel.set_end
        windDir.text = viewModel.windDirectionString
        // Если в windDir.text есть текстовое значение, при помощи метода changeWindIcon получаем необходимую иконку с направлением ветра
        if let windString = windDir.text {
            windDirectionIcon.image = service.changeWindIcon(windDirection: windString)
        }
    }
    
    // MARK: - ImageViews for icons
    
    // Имэджвью для вывода иконки погодных условий
    private lazy var conditionIcon = UIImageView.makeImageViewWithoutImage(contentMode: .scaleAspectFit)

    // Имэджвью для вывода иконки давления
    private lazy var pressureIcon = UIImageView.makeImageViewWithImage(systemName: "thermometer.high", tintColor: .systemBlue, contentMode: .scaleAspectFit)

    // Имэджвью для вывода иконки давления
    private lazy var humidityIcon = UIImageView.makeImageViewWithImage(systemName: "humidity", tintColor: .systemBlue, contentMode: .scaleAspectFit)

    // Имэджвью для вывода иконки скорости ветра
    private lazy var windIcon = UIImageView.makeImageViewWithImage(systemName: "wind", tintColor: .systemBlue, contentMode: .scaleAspectFit)

    // Имэджвью для вывода иконки времени восхода солнца
    private lazy var riseIcon = UIImageView.makeImageViewWithImage(systemName: "sunrise", tintColor: .systemBlue, contentMode: .scaleAspectFit)
    
    // Имэджвью для вывода иконки времени захода солнца
    private lazy var sunsetIcon = UIImageView.makeImageViewWithImage(systemName: "sunset", tintColor: .systemBlue, contentMode: .scaleAspectFit)

    // Имэджвью для вывода иконки направления ветра
    private lazy var windDirectionIcon = UIImageView.makeImageViewWithoutImage(contentMode: .scaleAspectFit)

    // MARK: - Labels
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = UILabel.makeLabel(fontSize: .title1, textColor: .black)
    
    // Лейбл для текущей температуры
    private lazy var weatherTemperature: UILabel = UILabel.makeLabel(fontSize: .title1, textColor: .white)
    
    // Лейбл для погодных условий
    private lazy var weatherCondition: UILabel = UILabel.makeLabel(fontSize: .callout, textColor: .white)
    
    // Лейбл для давления воздуха
    private lazy var weatherPressure: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)
    
    // Лейбл для скорости ветра
    private lazy var windSpeed: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)
    
    // Лейбл для скорости ветра
    private lazy var humidity: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)

    // Лейбл для минимальной температуры
    private lazy var minTemp: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .white)
    
    // Лейбл для максимальной температуры
    private lazy var maxTemp: UILabel = UILabel.makeLabel(fontSize: .title3, textColor: .white)
    
    // Лейбл для минимальной + максимальной температуры
    private lazy var averageTemp: UILabel = UILabel.makeLabel(fontSize: .callout, textColor: .white)
    
    // Лейбл для отображения времени замера погоды
    private lazy var obsTime: UILabel = UILabel.makeLabel(fontSize: .callout, textColor: .systemBlue)
    
    // Лейбл для отображения времени восхода солнца
    private lazy var riseBegin: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)
    
    // Лейбл для отображения времени восхода солнца
    private lazy var sunset: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)
    
    // Лейбл для направления ветра
    private lazy var windDir: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .systemBlue)
    
    // MARK: - Верхний блок StackView с названием города и временем прогноза
    
    // StackView для названия города
    private lazy var upperStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemGray6, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [cityName, obsTime], addShadow: false)

    // MARK: - Средний блок StackView с иконкой погодных условий, температурой, средней температурой
    
    // Стеквью для иконки и middleRightStackView
    private lazy var middleStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .horizontal, contentMode: .scaleAspectFit, viewToAdd: [conditionIcon, middleRightStackView], addShadow: false)
    
    // Стэквью для текущей температуры, средней температуры, погодных условий
    private lazy var middleRightStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [weatherTemperature, averageTemp, weatherCondition], addShadow: false)

    //MARK: - Нижний блок с иконками StackView. Первая строка

    // Стэквью для pressureStackView, windSpeedStackView
    private lazy var bottomFirstStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemGray6, axis: .horizontal, contentMode: .scaleAspectFill, viewToAdd: [pressureStackView, windSpeedStackView, humidityStackView], addShadow: false)
    
    // Стэквью для давления воздуха, для иконки давления воздуха
    private lazy var pressureStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [weatherPressure, pressureIcon], addShadow: true)
    
    // Стэквью для скорости ветра, для иконки скорости ветра
    private lazy var windSpeedStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [windSpeed, windIcon], addShadow: true)
    
    // Стэквью для влажности воздуха, для иконки влажности воздуха
    private lazy var humidityStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [humidity, humidityIcon], addShadow: true)

    //MARK: - Нижний блок с иконками StackView. Вторая строка

    // Стэквью для времени восхода солнца,
    private lazy var bottomSecondStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemGray6, axis: .horizontal, contentMode: .scaleAspectFill, viewToAdd: [riseBeginStackView, sunsetStackView, windDirStackView], addShadow: false)
    
    // Стэквью для восхода солнца, иконки восхода солнца
    private lazy var riseBeginStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [riseBegin, riseIcon], addShadow: true)
    
    // Стэквью для заката солнца, иконки заката солнца
    private lazy var sunsetStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [sunset, sunsetIcon], addShadow: true)
    
    // Стэквью для заката направления ветра
    private lazy var windDirStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .white, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [windDir, windDirectionIcon], addShadow: true)
    
    
    // MARK: - Constraints
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
            middleStackView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: ViewMetrics.defaultAnchor),
            middleStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewMetrics.mediumViewStackHeight),
            
            // Констрейнты для иконки
            conditionIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            conditionIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            pressureIcon.widthAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            pressureIcon.heightAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            // Устанавливаем ширину для иконки
            windIcon.widthAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            windIcon.heightAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            // Устанавливаем ширину для иконки влажности
            humidityIcon.widthAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            humidityIcon.heightAnchor.constraint(equalToConstant: ViewMetrics.iconsScale),
            
            // Стеквью для давления воздуха, скорости ветра, минимальной и максимальной температуры
            bottomFirstStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomFirstStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomFirstStackView.topAnchor.constraint(equalTo: middleStackView.bottomAnchor, constant: ViewMetrics.defaultAnchor),
            bottomFirstStackView.heightAnchor.constraint(equalToConstant: ViewMetrics.bottomViewStackHeight),
            
            // Стеквью для давления воздуха, скорости ветра, минимальной и максимальной температуры
            bottomSecondStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSecondStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSecondStackView.topAnchor.constraint(equalTo: bottomFirstStackView.bottomAnchor, constant: ViewMetrics.defaultAnchor),
            bottomSecondStackView.heightAnchor.constraint(equalToConstant: ViewMetrics.bottomViewStackHeight)
        ])
    }
}
