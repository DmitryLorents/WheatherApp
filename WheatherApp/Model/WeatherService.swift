//
//  WeatherService.swift
//  WheatherApp
//
//  Created by Mac on 02.03.2023.
//

import Foundation
import CoreLocation

enum ServiceError: Error  {
    case network(statusCode: Int)
    case parsing
    case general(reason: String)
}

protocol WeatherServiceDelegate: AnyObject {
    func didFetchWeather(_weatherService: WeatherService, _ weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, _ error: ServiceError)
}

struct WeatherService {
    weak var delegate: WeatherServiceDelegate?
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=ce5edb27133f4b3a9eab5abfe8072942&units=metric")!
    
    func fetchWeather(cityName: String) {
        guard let urlEncodedCityName  = cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            assertionFailure("Could not encode city named: \(cityName)") //Deebug only
            return
        }
        let urlString = "\(weatherURL)&q=\(urlEncodedCityName)"
        performRequest(with: urlString)
        
        //        let weatherModel = WeatherModel(conditionId: 700, cityName: cityName, temperature: -10)
        //        delegate?.didFetchWeather(_weatherService: self, weatherModel)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        //        let weatherModel = WeatherModel(conditionId: 800, cityName: "Paris", temperature: 25)
        //        delegate?.didFetchWeather(_weatherService: self, weatherModel)
    }
    
    func performRequest(with urlString: String) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil  else {
                let generalError = ServiceError.general(reason: "Check network ability.")
                DispatchQueue.main.async {
                    self.delegate?.didFailWithError(self, generalError)
                }
                return
            }
            
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    DispatchQueue.main.async {
                        self.delegate?.didFetchWeather(_weatherService: self, weather)
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        guard let decodedData = try? JSONDecoder().decode(WeatherData.self, from: weatherData) else {
            DispatchQueue.main.async {
                self.delegate?.didFailWithError(self, ServiceError.parsing)
            }
            return nil
            
        }
        let id = decodedData.weather[0].id
        let temp = decodedData.main.temp
        let name = decodedData.name
        let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
        return weather
    }
    
}
