//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 15.05.2023.
//
import UIKit

final class RootViewController: UIViewController {
    private let moduleView = RootView()

    override func loadView() {
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        moduleView.render(
            .init(
                date: "Today, May 7th, 2021",
                city: "Barcelona",
                country: "Spain"
            )
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

// MARK: - Private Methods

private extension RootViewController {
    private func configureNavigationBar() {
        let button = UIBarButtonItem(
            systemItem: .search,
            primaryAction: UIAction{ _ in
            debugPrint("Search button tapped")
            }
        )
        button.tintColor = .white

        navigationItem.rightBarButtonItem = button
    }
}
