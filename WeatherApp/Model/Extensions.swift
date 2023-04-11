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
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

extension UILabel {
    static func makeLabel(fontName: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = textColor
        label.font = UIFont(name: fontName, size: fontSize)
        label.textAlignment = .center
        return label
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
    static func makeStackView(backgroundColor: UIColor, axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode, viewToAdd: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: viewToAdd)
        stackView.backgroundColor = backgroundColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.layer.cornerRadius = 10
        stackView.contentMode = .scaleAspectFill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        return stackView
    }
}
















