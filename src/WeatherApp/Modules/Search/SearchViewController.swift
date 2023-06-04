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
    private let apiService = ApiService()

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

        moduleView.editingChanged = { [weak self] text in
            guard
                let self,
                let text, !text.isEmpty
            else {
                self?.moduleView.render(.init(items: []))
                return
            }

            DispatchQueue.global().asyncDeduped(target: self, after: 0.5) {
                self.obtainGeocoding(quary: text)
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion("Hello, World - SearchViewController")
    }
}

private extension SearchViewController {
    func configureNavigationBar() {
    }

    func obtainGeocoding(quary: String) {
        Task {
            do {
                let data = try await apiService.obtainGeocoding(query: quary)

                moduleView.render(
                    .init(
                        items: data
                            .map {
                                "\($0.name ?? ""), \($0.country ?? "")"
                            }
                            .withoutDuplicates()
                    )
                )
            } catch {
                debugPrint(error)
            }
        }
    }
}
