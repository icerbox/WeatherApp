//
//  CitiesListTableViewCell.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

final class CitiesListTableViewCell: UITableViewCell {
    
    static let identifier = "CitiesListTableViewCell"
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
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
        label.font = UIFont(name: "Helvetica-Bold", size: 36)
        label.textAlignment = .center
        return label
    }()
    
    // Стеквью для всех полей
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(cityName)
        stackView.addArrangedSubview(rightStackView)
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(weatherTemperature)
        stackView.addArrangedSubview(weatherCondition)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод для сборки данных из вьюмодели
    func configure(_ viewModel: WeatherData) {
        cityName.text = viewModel.name
        weatherCondition.text = viewModel.conditionString
        weatherTemperature.text = "\(String(describing: viewModel.temperatureString))℃"
    }
        
    // Устанавливаем констрейнты
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
