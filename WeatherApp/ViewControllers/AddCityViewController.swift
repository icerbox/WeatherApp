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
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(cityName)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)
    }
    func setupConstraints() {
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


