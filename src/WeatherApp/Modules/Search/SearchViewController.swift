//
//  SearchViewContorller.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 25.05.2023.
//

import SnapKit
import SwifterSwift
import Then
import UIKit

final class SearchViewController: UIViewController {
    private let moduleView = SearchView()

    private var completion: (String) -> Void

    init(completion: @escaping (String) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = moduleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion("Hello, World - SearchViewController")
    }
}
