//
//  WeatherApiManager.swift
//  WeatherApp
//
//  Created by Prachi Bile on 25/05/21.
//

import Foundation
import CoreLocation

class WeatherApiManager {
    
    func getWeather(weatherUrlStr: String, completion: @escaping (WeatherData?, String?) -> Void) {
        print("weather URL in WeatherApiManager : \(weatherUrlStr)")

        performRequest(with: weatherUrlStr, completionHandler: { weather, error in
            completion(weather, error)
        })
    }
    
    func performRequest(with weatherUrlStr: String, completionHandler: @escaping (WeatherData?, String) -> Void) {
        
        var decodedData: WeatherData!
        
        if let weatherURL = URL(string: weatherUrlStr) {
                        
            let session = URLSession(configuration: .default)
         
            let task = session.dataTask(with: weatherURL) { responseData, responseFromUrl, responseError in
                
                guard responseError == nil else {
                    print("Error in performRequest...\(responseError!.localizedDescription)")
                    completionHandler(nil, "Error encountered")
                    return
                }
                
                guard let data = responseData else {
                    print("No data received from performRequest...")
                    completionHandler(nil, "No data received from api")
                    return
                }
                
                guard let response = responseFromUrl as? HTTPURLResponse else {
                    print("No response received from performRequest...")
                    completionHandler(nil, "no response received from api")
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed while calling API...status code - \(response.statusCode)")
                    completionHandler(nil, "Status code is other than 200")
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
                    
                    completionHandler(decodedData, "")
                    
                } catch {
                    print("Error while JSON decoding...")
                    return
                }
            }
            task.resume()
        }
    }
}
