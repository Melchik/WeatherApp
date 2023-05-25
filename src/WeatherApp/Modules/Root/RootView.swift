//
//  RootView.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 15.05.2023.
//

import SnapKit
import SwifterSwift
import Then
import UIKit

final class RootView: UIView {
    // MARK: - Props

    struct Props: Equatable {
        let date: String
        let city: String
        let country: String
        let temperature: String
        let windStatus: String
        let windSpeed: String
        let visibility: String
        let visibilityDistance: String
        let humidity: String
        let humidityPercent: String
        let airPressure: String
        let airMb: String
    }

    // MARK: - Private Props

    private var props: Props?

    // MARK: - Views

    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .white
    }

    private lazy var cityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 40, weight: .bold)
        $0.textColor = .white
    }

    private lazy var countryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .white
    }

    private lazy var vStackLabel = UIStackView(
        arrangedSubviews: [
            dateLabel,
            cityLabel,
            countryLabel
        ],
        axis: .vertical,
        spacing: 0.0,
        alignment: .center
    )

    private lazy var temperatureView = UIView().then {
        $0.backgroundColor = .white
        $0.layerCornerRadius = 120
    }

    private lazy var currentWeatherImageView = UIImageView(image: UIImage(systemName: "cloud.rain.fill"))

    private lazy var currentTemperatureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 100, weight: .thin)
        $0.textColor = .black
    }

    private lazy var windStatusLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }

    private lazy var windSpeedLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .thin)
        $0.textColor = .white
    }

    private lazy var vStackWindLabel = UIStackView(
        arrangedSubviews: [
            windStatusLabel,
            windSpeedLabel
        ],
        axis: .vertical,
        spacing: 8,
        alignment: .center
    )

    private lazy var visibilityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }

    private lazy var visibilityDistanceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .thin)
        $0.textColor = .white
    }

    private lazy var vStackVisibilityLabel = UIStackView(
        arrangedSubviews: [
            visibilityLabel,
            visibilityDistanceLabel
        ],
        axis: .vertical,
        spacing: 8,
        alignment: .center
    )

    private lazy var humidityLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }

    private lazy var humidityPercentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .thin)
        $0.textColor = .white
    }

    private lazy var vStackHumidityLabel = UIStackView(
        arrangedSubviews: [
            humidityLabel,
            humidityPercentLabel
        ],
        axis: .vertical,
        spacing: 8,
        alignment: .center
    )

    private lazy var airPressureLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .white
    }

    private lazy var airMbLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .thin)
        $0.textColor = .white
    }

    private lazy var vStackAirPressureLabel = UIStackView(
        arrangedSubviews: [
            airPressureLabel,
            airMbLabel
        ],
        axis: .vertical,
        spacing: 8,
        alignment: .center
    )
    // MARK: - LifeCycle

    init() {
        super.init(frame: .zero)

        setup()
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal Methods

extension RootView {
    func render(_ props: Props) {
        guard self.props != props else { return }
        self.props = props

        dateLabel.text = props.date
        cityLabel.text = props.city
        countryLabel.text = props.country
        currentTemperatureLabel.text = props.temperature
        windStatusLabel.text = props.windStatus
        windSpeedLabel.text = props.windSpeed
        visibilityLabel.text = props.visibility
        visibilityDistanceLabel.text = props.visibilityDistance
        humidityLabel.text = props.humidity
        humidityPercentLabel.text = props.humidityPercent
        airPressureLabel.text = props.airPressure
        airMbLabel.text = props.airMb
    }
}

// MARK: - Private Methods

private extension RootView {
    /// Настройка View
    func setup() {
        let gradient = CAGradientLayer(
            colors: [
                UIColor(hexString: "30A2C5") ?? .cyan,
                .clear
            ]
        ).then {
            $0.frame = UIScreen.main.bounds
        }

        self.layer.addSublayer(gradient)

        backgroundColor = UIColor(hexString: "00242F")
    }

    /// Добавление Views
    func setupViews() {
        addSubviews([
            temperatureView,
            currentWeatherImageView,
            currentTemperatureLabel
        ])

        addSubviews([
            vStackLabel,
            vStackWindLabel,
            vStackVisibilityLabel,
            vStackHumidityLabel,
            vStackAirPressureLabel
        ])
    }

    /// Установка констреинтов
    func setupConstraints() {
        vStackLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        temperatureView.snp.makeConstraints {
            $0.top.equalTo(vStackLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.temperatureViewSize)
        }

        currentWeatherImageView.snp.makeConstraints {
            $0.top.equalTo(vStackLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.currentWeatherImageSize)
        }

        currentTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(vStackLabel.snp.bottom).offset(87)
            $0.centerX.equalToSuperview()
        }

        vStackWindLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureView.snp.bottom).offset(31)
            $0.leading.equalToSuperview().inset(57)
        }

        vStackVisibilityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureView.snp.bottom).offset(31)
            $0.trailing.equalToSuperview().inset(66)
        }

        vStackHumidityLabel.snp.makeConstraints {
            $0.top.equalTo(vStackWindLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(67)
        }

        vStackAirPressureLabel.snp.makeConstraints {
            $0.top.equalTo(vStackVisibilityLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(60)
        }
    }
}

// MARK: - Constants

private extension RootView {
    enum Constants {
        static let temperatureViewSize = CGSize(width: 240, height: 240)
        static let currentWeatherImageSize = CGSize(width: 75, height: 75)
    }
}
