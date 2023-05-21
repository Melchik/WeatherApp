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
        addSubview(vStackLabel)
        addSubview(temperatureView)
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
            $0.size.equalTo(CGSize(width: 240, height: 240))
        }
    }
}

// MARK: - Constants

private extension RootView {
    enum Constants {
    }
}
