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
    }

    // MARK: - Private Props

    private var props: Props?

    // MARK: - Views

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
    }
}

// MARK: - Private Methods

private extension RootView {
    /// Настройка View
    func setup() {
        // swiftlint:disable closure_end_indentation
        let gradient = CAGradientLayer(
            colors: [
                UIColor(hexString: "30A2C5") ?? .cyan,
                .clear
            ]
        ).then {
            $0.frame = UIScreen.main.bounds
        }
        // swiftlint:enable closure_end_indentation

        self.layer.addSublayer(gradient)

        backgroundColor = UIColor(hexString: "00242F")
    }

    /// Добавление Views
    func setupViews() {
    }

    /// Установка констреинтов
    func setupConstraints() {
    }
}

// MARK: - Constants

private extension RootView {
    enum Constants {
    }
}
