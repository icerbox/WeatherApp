//
//  CitiesListTableViewCell.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

final class CitiesListTableViewCell: UITableViewCell {
    
    static let identifier = "CitiesListTableViewCell"
    
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
        realFeel.text = "Чувствуется как: \(String(describing: viewModel.feelsLike))℃"
    }
    
    // MARK: - Labels
    
    // Лейбл для названия города
    private lazy var cityName: UILabel = UILabel.makeLabel(fontSize: .title1, textColor: .white)
    
    // Лейбл для погодных условий
    private lazy var weatherCondition: UILabel = UILabel.makeLabel(fontSize: .body, textColor: .white)
    
    // Лейбл для текущей температуры
    private lazy var weatherTemperature: UILabel = UILabel.makeLabel(fontSize: .title1, textColor: .white)
    
    // Лейбл для ощущаемой температуры
    private lazy var realFeel: UILabel = UILabel.makeLabel(fontSize: .footnote, textColor: .lightText)
    
    // MARK: - StackViews
    
    // Стеквью для всех полей
    private lazy var stackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .horizontal, contentMode: .scaleAspectFill, viewToAdd: [cityName, rightStackView], addShadow: true)
    
    // Стэквью для текущей температуры, для погодных условий
    private lazy var rightStackView: UIStackView = UIStackView.makeStackView(backgroundColor: .systemBlue, axis: .vertical, contentMode: .scaleAspectFill, viewToAdd: [weatherTemperature, weatherCondition, realFeel], addShadow: false)
    
    // MARK: - Constraints
    
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
