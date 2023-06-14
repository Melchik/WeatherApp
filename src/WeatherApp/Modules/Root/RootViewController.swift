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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        
        if let cords = UserDefaultsService.shared.fetchCoordinates() {
            obtainCurrentWeather(lat: cords.lat, lon: cords.lon)
        } else {
            routeToSearchView()
        }
    }
}

// MARK: - Private Methods

private extension RootViewController {
    private func configureNavigationBar() {
        let button = UIBarButtonItem(
            systemItem: .search,
            primaryAction: UIAction{ [weak self] _ in
                self?.routeToSearchView()
            }
        )
        button.tintColor = .white

        navigationItem.rightBarButtonItem = button
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    func routeToSearchView() {
        navigationController?.pushViewController(SearchViewController())
    }

    func obtainCurrentWeather(lat: Double, lon: Double) {
        Task {
            do {
                let response = try await apiService.obtainCurrentWeather(lat: lat, lon: lon)

                moduleView.render(
                    .init(
                        date: "\(Date.now.string(withFormat: "EEEE', 'MMM d', 'yyyy", locale: Locale(identifier: "en_US")))",
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
                        airMb: "\(response.main?.pressure?.string ?? "0") mb",
                        iconUrl: ImageService.fetchImage(iconCode: response.weather?.first?.icon ?? "01d")
                    )
                )
            } catch {
                debugPrint(error)
            }
        }
    }
}
