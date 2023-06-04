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
        let items: [String]
    }

    // MARK: - Internal Props

    var editingChanged: ((String?) -> Void)?

    // MARK: - Private Props

    private var props: Props?
    private var items: [String] = []

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

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
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
        self.items = props.items

        tableView.reloadData()
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

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellWithClass: SearchTableViewCell.self)
        tableView.separatorStyle = .none

        searchBar.textField?.addAction(
            UIAction { [weak self] _ in
                self?.editingChanged?(self?.searchBar.text)
            },
            for: .editingChanged
        )
    }

    /// Добавление Views
    func setupViews() {
        searchingView.addSubviews([
            searchBar,
            tableView
        ])
        addSubview(searchingView)
    }

    /// Установка констреинтов
    func setupConstraints() {
        searchingView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.searchingViewSize.height)
        }

        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.searchingTextFieldSize)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(14)
            $0.leading.equalTo(searchBar.snp.leading)
            $0.trailing.bottom.equalToSuperview().inset(14)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SearchTableViewCell.self)
        cell.render(.init(value: items[indexPath.row]))
        return cell
    }
}

// MARK: - Constants

private extension SearchView {
    enum Constants {
        static let searchingViewSize = CGSize(width: 414, height: 366)
        static let searchingTextFieldSize = CGSize(width: 305, height: 44)
    }
}
