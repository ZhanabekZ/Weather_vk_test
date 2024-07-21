//
//  WeatherCondition.swift
//  Weather_vk
//
//  Created by ZhZinekenov on 21.07.2024.
//
import Foundation

enum WeatherCondition: String, CaseIterable {
    case clear = "Clear"
    case rain = "Rain"
    case thunderstorm = "Thunderstorm"
    case fog = "Fog"
    
    var localizedName: String {
        switch self {
        case .clear:
            return NSLocalizedString("Clear", comment: "")
        case .rain:
            return NSLocalizedString("Rain", comment: "")
        case .thunderstorm:
            return NSLocalizedString("Thunderstorm", comment: "")
        case .fog:
            return NSLocalizedString("Fog", comment: "")
        }
    }
}
