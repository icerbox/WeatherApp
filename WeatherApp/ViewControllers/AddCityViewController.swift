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
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Отменить", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    private lazy var cityName: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.placeholder = "Введите название города"
        return textField
    }()
    
    func setupViews() {
        view.addSubview(cityName)
        view.addSubview(doneButton)
        view.addSubview(cancelButton)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cityName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityName.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cityName.widthAnchor.constraint(equalToConstant: 200),
            cityName.heightAnchor.constraint(equalToConstant: 50),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 20),
            doneButton.widthAnchor.constraint(equalToConstant: 200),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 200),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func done(_ sender: UIButton) {
        print("Метод done() выполнена, cityName.text: \(String(describing: cityName.text))")
        guard let item = cityName.text else { return }
        print(item)
        delegate?.addCityViewController(self, didFinishAdding: item)
        
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        for i in viewControllers {
            print("viewController: \(i)")
        }
        
        for viewController in viewControllers {
            if viewController is RootViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
                break
            }
        }
    }
    
    @objc func cancel(_ sender: UIButton) {
        print("Метод cancel() выполнен")
        delegate?.addCityViewControllerDidCancel(self)
        self.navigationController?.popViewController(animated: true)
    }
    
}


