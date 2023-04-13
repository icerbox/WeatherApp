//
//  Extension.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 11.04.2023.
//

import UIKit

extension UIButton {
    static func makeButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ViewMetrics.buttonColor
        button.layer.cornerRadius = ViewMetrics.cornerRadius
        button.setTitle(title, for: .normal)
        button.addTarget(AnyObject.self, action: action, for: .touchUpInside)
        return button
    }
}

extension UILabel {
    static func makeLabel(fontSize: UIFont.TextStyle ,textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: fontSize)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = textColor
        label.textAlignment = .center
        return label
    }
}

extension UIImageView {
    static func makeImageViewWithImage(systemName: String, tintColor: UIColor, contentMode: UIView.ContentMode) -> UIImageView {
        var image = UIImageView(image: UIImage(systemName: systemName))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = tintColor
        image.contentMode = contentMode
        return image
    }

    static func makeImageViewWithoutImage(contentMode: UIView.ContentMode) -> UIImageView {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = contentMode
        return image
    }
}



extension UITextField {
    func setBorderColor() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.masksToBounds = true
    }
}

extension UIStackView {
    static func makeStackView(backgroundColor: UIColor, axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode, viewToAdd: [UIView], addShadow: Bool) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: viewToAdd)
        stackView.backgroundColor = backgroundColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = contentMode
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        if addShadow {
            stackView.addShadow()
        }
        return stackView
    }
    
    func addShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.cornerRadius = 10
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
















