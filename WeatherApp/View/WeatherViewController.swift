//
//  ViewController.swift
//  WeatherApp
//
//  Created by Prachi Bile on 25/05/21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
        
    @IBOutlet weak var weatherSearchBar: UISearchBar!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var weatherViewModelObj = WeatherViewModel()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator.hidesWhenStopped = true
        locationSettings()
        weatherSearchBar.delegate = self
        weatherViewModelObj.delegate = self
    }
    
    func locationSettings() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

//MARK:- UISearchBarDelegate

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadingIndicator.startAnimating()
        weatherViewModelObj.fetchWeather(location: searchBar.text!)
    }
}

//MARK: - sCLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherViewModelObj.fetchWeather(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//MARK: - WeatherViewModelDelegate

extension WeatherViewController: WeatherViewModelDelegate {
    
    func didUpdadeWeather(weatherData: WeatherData) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weatherData.name
            self.tempLabel.text = String(weatherData.main.temp)+" `C"
            for weather in weatherData.weather {
                self.weatherDescriptionLabel.text = weather.description
                let weatherImageUrl = URL(string: "\(Constants.IMAGE_URL)\(weather.icon)@2x.png")
                self.fetchImage(weatherImageUrl: weatherImageUrl)
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.hidesWhenStopped = true
        }
    }
    
    func fetchImage(weatherImageUrl: URL!) {
        if weatherImageUrl != nil {
            DispatchQueue.global().async {
                let weatherImageData = try? Data(contentsOf: weatherImageUrl!)
                if let safeWeatherImageData = weatherImageData {
                    let weatherImage = UIImage(data: safeWeatherImageData)
                    DispatchQueue.main.async {
                        self.weatherImageView.image = weatherImage
                    }
                }
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
