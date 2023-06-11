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
    private let apiService = ApiService()

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
                let vc = SearchViewController { [weak self] lat, lon in
                    self?.obtainCurrentWeather(lat: lat, lon: lon)
                }

                self?.navigationController?.pushViewController(vc)
            }
        )
        button.tintColor = .white

        navigationItem.rightBarButtonItem = button
    }

    func obtainCurrentWeather(lat: Double, lon: Double) {
        Task {
            do {
                let response = try await apiService.obtainCurrentWeather(lat: lat, lon: lon)

                moduleView.render(
                    .init(
                        date: "\(Date.now.string(withFormat: "EEEE', 'MMM d', 'yyyy"))",
                        city: response.name ?? "---",
                        country: response.sys?.country ?? "---",
                        temperature: "\(response.main?.temp?.string ?? "1" ) °C",
                        windStatus: "Wind status",
                        windSpeed: "\(response.wind?.speed?.string ?? "0" ) mph",
                        visibility: "Visibility",
                        visibilityDistance: "\(response.visibility?.string ?? "0") miles",
                        humidity: "Humidity",
                        humidityPercent: "\(response.main?.humidity?.string ?? "0") %",
                        airPressure: "Air pressure",
                        airMb: "\(response.main?.pressure?.string ?? "0") mb"
                    )
                )
            } catch {
                debugPrint(error)
            }
        }
    }
}
