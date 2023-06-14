//
//  ImageService.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 14.06.2023.
//

import Foundation

// swiftlint:disable force_unwrapping

public enum ImageService {
    static func fetchImage(iconCode: String) -> URL {
        URL(string: "https://openweathermap.org/img/wn/\(iconCode)@4x.png")!
    }
}
