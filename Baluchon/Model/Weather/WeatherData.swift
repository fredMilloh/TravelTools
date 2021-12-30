//
//  WeatherData.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

struct WeatherData: Decodable {
    let city: String
    let country: Country
    let skyCondition: [SkyCondition]
    let temperature: Temperature
    
    
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case country = "sys"
        case skyCondition = "weather"
        case temperature = "main"
    }
}

// MARK: - Error
enum WeatherError: Error {
    case error(error: Error?)
    case missingData
    case cannotProcessData
    case wrongUrl
}

