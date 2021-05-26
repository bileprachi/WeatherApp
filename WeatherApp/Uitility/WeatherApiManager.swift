//
//  WeatherApiManager.swift
//  WeatherApp
//
//  Created by Prachi Bile on 25/05/21.
//

import Foundation
import CoreLocation

class WeatherApiManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=\(Constants.CELSIUS)&appid=\(Constants.API_KEY)"
    
    func getWeather(location: String, completion: @escaping (WeatherData?, Error?) -> Void) {
        
        let weatherURLString = "\(weatherURL)&q=\(location)"
        
        print("weather URL in WeatherApiManager : \(weatherURLString)")

        performRequest(with: weatherURLString, completionHandler: { weather, error in
            completion(weather, nil)
        })
    }
    
    func getWeather(lat: CLLocationDegrees, long: CLLocationDegrees, completion: @escaping (WeatherData?, Error?) -> Void) {
        
        let weatherURLString = "\(weatherURL)&lat=\(lat)&lon=\(long)"
        
        print("weather URL in WeatherApiManager : \(weatherURLString)")

        performRequest(with: weatherURLString, completionHandler: { weather, error in
            completion(weather, nil)
        })
    }
    
    func performRequest(with weatherUrlStr: String, completionHandler: @escaping (WeatherData?, Error?) -> Void) {
        
        var decodedData: WeatherData!
        
        if let weatherURL = URL(string: weatherUrlStr) {
                        
            let session = URLSession(configuration: .default)
         
            let task = session.dataTask(with: weatherURL) { responseData, responseFromUrl, responseError in
                
                guard responseError == nil else {
                    print("Error in performRequest...\(responseError!.localizedDescription)")
                    return
                }
                
                guard let data = responseData else {
                    print("No data received from performRequest...")
                    return
                }
                
                guard let response = responseFromUrl as? HTTPURLResponse else {
                    print("No response received from performRequest...")
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed while calling API...status code - \(response.statusCode)")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    decodedData = try decoder.decode(WeatherData.self, from: data)
                    
                    print("Inside JSONDecoder")
                    print("Temp : \(decodedData.main.temp)")
                    print("Weather Description : \(decodedData.weather[0].description)")
                    print("Weather main : \(decodedData.weather[0].main)")
                    print("Weather icon : \(decodedData.weather[0].icon)")
                    print("Weather city name : \(decodedData.name)")
                    print(type(of: decodedData))
                    
                    completionHandler(decodedData, nil)
                    
                } catch {
                    print("Error while JSON decoding...")
                    return
                }
            }
            task.resume()
        }
    }
}
