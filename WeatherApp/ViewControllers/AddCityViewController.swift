//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

protocol CityAppender: AnyObject {
    func cancelButtonTap(_ controller: AddCityViewController)
    func doneButtonTap(_ controller: AddCityViewController, didFinishAdding item: String)
}

final class AddCityViewController: UIViewController {
    
    weak var delegate: CityAppender?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private lazy var doneButton = UIButton.makeButton(title: "Сохранить", action: #selector(done))
    
    private lazy var cancelButton = UIButton.makeButton(title: "Отменить", action: #selector(cancel))
        
    private lazy var cityName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.setBorderColor()
        textField.borderStyle = .line
        textField.placeholder = "Введите название города"
        return textField
    }()
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(cityName)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cityName.safeAreaLayoutGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            cityName.safeAreaLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cityName.safeAreaLayoutGuide.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            doneButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            doneButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07),
            cancelButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            cancelButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07)
        ])
    }
    
    @objc
    private func done(_ sender: UIButton) {
        guard let item = cityName.text else {
            return
        }
        delegate?.doneButtonTap(self, didFinishAdding: item)
        
        guard let viewControllers = self.navigationController?.viewControllers else {
            return
        }
        
        for viewController in viewControllers {
            if viewController is RootViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                break
            }
        }
    }
    
    @objc
    private func cancel(_ sender: UIButton) {
        delegate?.cancelButtonTap(self)
        self.navigationController?.popViewController(animated: true)
    }
}


