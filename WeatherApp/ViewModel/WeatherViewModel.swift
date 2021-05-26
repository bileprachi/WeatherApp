//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Prachi Bile on 25/05/21.
//

import Foundation
import CoreLocation

protocol WeatherViewModelDelegate: AnyObject {
    func didUpdadeWeather(weatherData: WeatherData)
    func didFailWithError(error: Error)
}

class WeatherViewModel {
    
    let weatherApiManagerObj = WeatherApiManager()
    weak var delegate: WeatherViewModelDelegate?
    
    func fetchWeather(location: String) {
        print("City in View Model: \(location)")
        
        weatherApiManagerObj.getWeather(location: location, completion: { weatherData, error in
            self.delegate?.didUpdadeWeather(weatherData: weatherData!)
        })
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("latitude: \(latitude), longitude: \(longitude)")
        
        weatherApiManagerObj.getWeather(lat: latitude, long: longitude, completion: { weatherData, error in
            self.delegate?.didUpdadeWeather(weatherData: weatherData!)
        })
    }
}
