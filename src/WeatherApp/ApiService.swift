//
//  ApiService.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 03.06.2023.
//

import Foundation

enum Errors: Error {
    case badUrl
}

struct ApiService {
    private let baseUrl = "https://api.openweathermap.org"
    private let apiKey = "6eda98e41b53dde03bf02985c4459550"

    func obtainGeocoding(query: String, limit: Int) async throws -> GeocodingResponse {
        var urlComponent = URLComponents(string: "\(baseUrl)/geo/1.0/direct")
        urlComponent?.queryItems = [
            .init(name: "q", value: query),
            .init(name: "limit", value: String(limit)),
            .init(name: "appid", value: apiKey)
        ]

        guard let url = urlComponent?.url else { throw Errors.badUrl }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try JSONDecoder().decode(GeocodingResponse.self, from: data)
    }
}
