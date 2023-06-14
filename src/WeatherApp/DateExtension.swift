//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Илья Поздняков on 14.06.2023.
//

import Foundation

public extension Date {
    func string(withFormat format: String = "dd/MM/yyyy HH:mm", locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
}
