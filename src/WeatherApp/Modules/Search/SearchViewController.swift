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

    private var completion: (Double, Double) -> Void

    private var response: GeocodingResponse?

    init(completion: @escaping (Double, Double) -> Void) {
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

        moduleView.didSelectRowAt = { [weak self] rowIndex in
            guard
                let response = self?.response,
                let item = response[safe: rowIndex],
                let lat = item.lat,
                let lon = item.lon
            else {
                return
            }

            self?.completion(lat, lon)
            self?.navigationController?.popViewController(animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
}

private extension SearchViewController {
    func configureNavigationBar() {
    }

    func obtainGeocoding(quary: String) {
        Task {
            do {
                response = try await apiService.obtainGeocoding(query: quary)
                guard let response else { return }

                moduleView.render(
                    .init(
                        items: response
                            .map {
                                "\($0.name ?? ""), \($0.country ?? "")"
                            }
                    )
                )
            } catch {
                debugPrint(error)
            }
        }
    }
}
