//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import UIKit

protocol AddCityViewControllerDelegate: AnyObject {
    func addCityViewControllerDidCancel(_ controller: AddCityViewController)
    func addCityViewController(_ controller: AddCityViewController, didFinishAdding item: String)
}

class AddCityViewController: UIViewController {
    
    weak var delegate: AddCityViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Отменить", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.borderStyle = .line
        textField.placeholder = "Введите название города"
        return textField
    }()
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(cityName)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            cityName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cityName.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            doneButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cancelButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
    }
    
    @objc func done(_ sender: UIButton) {
        guard let item = cityName.text else { return }
        delegate?.addCityViewController(self, didFinishAdding: item)
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            if viewController is RootViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                break
            }
        }
    }
    
    @objc func cancel(_ sender: UIButton) {
        delegate?.addCityViewControllerDidCancel(self)
        self.navigationController?.popViewController(animated: true)
    }
    
}


