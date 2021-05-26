//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Prachi Bile on 25/05/21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}
