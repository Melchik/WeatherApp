//
//  UserDefaultsService.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 14.06.2023.
//

import Foundation

public struct UserDefaultsService {
    // MARK: - Keys

    enum Keys: String {
        case lat = "latKey"
        case lon = "lonKey"
    }

    // MARK: - Shared

    public static let shared = UserDefaultsService()

    // MARK: - LifeCycle

    private init() {
    }

    // MARK: - Public Methods

    public func saveCoordinates(lat: Double, lon: Double) {
        UserDefaults.standard.setValue(lat, forKey: Keys.lat.rawValue)
        UserDefaults.standard.setValue(lon, forKey: Keys.lon.rawValue)
    }

    public func fetchCoordinates() -> (lat: Double, lon: Double)? {
        let lat = UserDefaults.standard.double(forKey: Keys.lat.rawValue)
        let lon = UserDefaults.standard.double(forKey: Keys.lon.rawValue)

        guard lat != 0 || lon != 0 else { return nil }

        return (lat, lon)
    }
}
