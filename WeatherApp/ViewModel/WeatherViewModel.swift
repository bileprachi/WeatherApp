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
    func didFailWithError(error: String)
}

class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    let weatherApiManagerObj = WeatherApiManager()
    let weatherURL = "\(WeatherURL.MAIN_URL)\(WeatherURL.CELSIUS)&\(WeatherURL.API_KEY)"
    
    func fetchWeather(location: String) {
        print("City in View Model: \(location)")
        
        let path = "\(weatherURL)&q=\(location)"
        print("path: \(path)")
        
        weatherApiManagerObj.getWeather(weatherUrlStr: path) { weatherData, error in
            if weatherData != nil {
                self.delegate?.didUpdadeWeather(weatherData: weatherData!)
            } else {
                self.delegate?.didFailWithError(error: error!)
            }
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        print("latitude: \(latitude), longitude: \(longitude)")
        
        let path = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print("path: \(path)")
        
        weatherApiManagerObj.getWeather(weatherUrlStr: path, completion: { weatherData, error in
            if weatherData != nil {
                self.delegate?.didUpdadeWeather(weatherData: weatherData!)
            } else {
                self.delegate?.didFailWithError(error: error!)
            }
        })
    }
}
