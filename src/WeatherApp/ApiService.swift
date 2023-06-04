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
    private let apiKey = "4f926c9820f56e1c6dc45c5ef78f65d7"

    func obtainGeocoding(query: String, limit: Int = 5) async throws -> GeocodingResponse {
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

    func obtainCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherResponse {
        var urlComponent = URLComponents(string: "\(baseUrl)/data/2.5/weather")
        urlComponent?.queryItems = [
            .init(name: "lat", value: String(lat)),
            .init(name: "lon", value: String(lon)),
            .init(name: "appid", value: apiKey),
            .init(name: "units", value: "metric")
        ]

        guard let url = urlComponent?.url else { throw Errors.badUrl }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
    }
}
