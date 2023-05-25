//
//  RootViewController.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 15.05.2023.
//
import SnapKit
import SwifterSwift
import Then
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
                country: "Spain",
                temperature: "10°C",
                windStatus: "Wind status",
                windSpeed: "7 mph",
                visibility: "Visibility",
                visibilityDistance: "6.4 miles",
                humidity: "Humidity",
                humidityPercent: "85%",
                airPressure: "Air pressure",
                airMb: "998 mb"
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
            primaryAction: UIAction{ [weak self] _ in
                let vc = SearchViewController {
                    debugPrint($0)
                }

                self?.navigationController?.pushViewController(vc)
            }
        )
        button.tintColor = .white

        navigationItem.rightBarButtonItem = button
    }
}
