//
//  AuthViewController.swift
//  WeatherApp
//
//  Created by Айсен Еремеев on 04.04.2023.
//

import Foundation
import WebKit

protocol AuthViewControllerDelegate: AnyObject {
    // Получаем токен
    func handleTokenChanged(token: String)
}

final class AuthViewController: UIViewController {
    // Создаем делегата
    weak var delegate: AuthViewControllerDelegate?
    private let webView = WKWebView()
    private let clientId = "50605982f3db45f999598634c776989f"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        guard let request = request else { return }
        webView.load(request)
        webView.navigationDelegate = self
    }
    private func setupViews() {
        view.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private var request: URLRequest? {
        guard var urlComponents = URLComponents(string: "https://oauth.yandex.ru/authorize") else { return nil }
            urlComponents.queryItems = [
              URLQueryItem(name: "response_type", value: "token"),
              URLQueryItem(name: "client_id", value: "\(clientId)")
            ]
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if let url = navigationAction.request.url {
            let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            guard let components = URLComponents(string: targetString) else { return }

            let token = components.queryItems?.first(where: { $0.name == "access_token" })?.value

            if let token = token {
                delegate?.handleTokenChanged(token: token)
            }
            dismiss(animated: true, completion: nil)
        }
        decisionHandler(.allow)
    }
}
