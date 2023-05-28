//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 28.05.2023.
//

import SnapKit
import SwifterSwift
import Then
import UIKit

final class SearchTableViewCell: UITableViewCell {
    // MARK: - Props

    struct Props: Equatable {
        let value: String
    }

    // MARK: - Private Props

    private var props: Props?

    // MARK: - Views

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

extension SearchTableViewCell {
    func render(_ props: Props) {
        guard self.props != props else { return }
        self.props = props

        mainLabel.text = props.value
    }
}

// MARK: - Private Methods

private extension SearchTableViewCell {
    /// Настройка View
    func setup() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    /// Добавление Views
    func setupViews() {
        contentView.addSubview(mainLabel)
    }

    /// Установка констреинтов
    func setupConstraints() {
        mainLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8.0)
        }
    }
}

// MARK: - Constants

private extension SearchTableViewCell {
    enum Constants {
    }
}
