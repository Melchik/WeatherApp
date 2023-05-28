//
//  SearchView.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 25.05.2023.
//

import SnapKit
import SwifterSwift
import Then
import UIKit

final class SearchView: UIView {
    // MARK: - Props

    struct Props: Equatable {
    }

    // MARK: - Private Props

    private var props: Props?

    // MARK: - Views

    private lazy var searchingView = UIView().then {
        $0.backgroundColor = .white
        $0.layerCornerRadius = 50
    }

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "SEARCH LOCATION"
        searchBar.searchTextField.setPlaceHolderTextColor(.black)
        searchBar.searchTextField.layerCornerRadius = 16
        return searchBar
    }()
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

extension SearchView {
    func render(_ props: Props) {
        guard self.props != props else { return }
        self.props = props
    }
}

// MARK: - Private Methods

private extension SearchView {
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
        searchingView.addSubviews([
            searchBar
        ])
        addSubview(searchingView)
    }

    /// Установка констреинтов
    func setupConstraints() {
        searchingView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.size.equalTo(Constants.searchingViewSize)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.searchingTextFieldSize)
        }
    }
}

// MARK: - Constants

private extension SearchView {
    enum Constants {
        static let searchingViewSize = CGSize(width: 414, height: 366)
        static let searchingTextFieldSize = CGSize(width: 305, height: 44)
    }
}
