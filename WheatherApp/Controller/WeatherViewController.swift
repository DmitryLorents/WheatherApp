//
//  ViewController.swift
//  WheatherApp
//
//  Created by Mac on 28.02.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    //background
    let backGroundView = UIImageView()
    
    //search
    let locationButton = UIButton()
    let searchButton = UIButton()
    let searchTextField = UITextField()
    let searchStackView = UIStackView()
    
    //wheather
    let rootStackView = UIStackView()
    let conditionImageView = UIImageView()
    let temperatureLabel = UILabel()
    let cityLabel = UILabel()
    
    //location
    let locationManager = CLLocationManager()
    
    var weatherService = WeatherService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        
    }
    
    
}
extension WeatherViewController {
    
    func setup() {
        //NotificationCenter.default.addObserver(self, selector: #selector(receiveWeather(_:)), name: .didReceiveWeather, object: nil)
        searchTextField.delegate = self
        locationManager.delegate = self
        weatherService.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func makeTemperatureText(with temperature: String)  -> NSAttributedString {
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)
        
        var plaintextAttributes = [NSAttributedString.Key: AnyObject]()
        plaintextAttributes[.font] = UIFont.systemFont(ofSize: 80)
        
        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "°C", attributes: plaintextAttributes))
        return text
    }
    func style() {
        
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.image = UIImage(named: "background")
        backGroundView.contentMode = .scaleAspectFill
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = .label
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        searchButton.translatesAutoresizingMaskIntoConstraints =  false
        searchButton.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .label
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        
        searchTextField.placeholder = "Search"
        searchTextField.translatesAutoresizingMaskIntoConstraints  = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.textAlignment = .right
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 10
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis  = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
        
        //wheather
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "sun.max")
        conditionImageView.tintColor = .label
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints  = false
        temperatureLabel.attributedText = makeTemperatureText(with: "22")
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.text = "Cupertino"
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    func layout() {
        //add views
        view.addSubview(backGroundView)
        
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        rootStackView.addArrangedSubview(searchStackView)
        rootStackView.addArrangedSubview(conditionImageView)
        rootStackView.addArrangedSubview(temperatureLabel)
        rootStackView.addArrangedSubview(cityLabel)
        view.addSubview(rootStackView)
        
        //        view.addSubview(locationButton)
        //        view.addSubview(searchButton)
        //        view.addSubview(searchTextField)
        
        //autoLayout
        
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1),
            searchStackView.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),
            conditionImageView.widthAnchor.constraint(equalTo: conditionImageView.heightAnchor),
            
            //            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            locationButton.heightAnchor.constraint(equalToConstant: 44),
            locationButton.widthAnchor.constraint(equalTo: locationButton.heightAnchor),
            
            //            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 1),
            searchButton.heightAnchor.constraint(equalTo: locationButton.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            
            //            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            searchTextField.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor, constant: 10),
            //            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.heightAnchor.constraint(equalTo: locationButton.heightAnchor)
        ])
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func handleWeather(weatherModel: WeatherModel) {
        updateUI(with: weatherModel)
    }
    @objc  func searchPressed(_ sender: UIButton) {
        //delegate
        searchTextField.endEditing(true)
        //closure
//        var service = WeatherClosureService()
//        let handler: (WeatherModel) -> Void = handleWeather(weatherModel:)
//        service.receiveWeatherHandler = handler
//        service.fetchWeather(cityName: "Stockholm")
        //notification service
//        let service = WeatherNotificationService()
//        service.fetchWeather(cityName: "New York")
    }
//    @objc func receiveWeather(_ notification: Notification) {
//        guard let data = notification.userInfo as? [String: WeatherModel] else {return}
//        guard let weatherModel = data["currentWeather"] else {return}
//
//        temperatureLabel.attributedText = makeTemperatureText(with: weatherModel.temperatureString)
//        conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
//        cityLabel.text = weatherModel.cityName
//    }
    //MARK: -UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherService.fetchWeather(cityName: city)
        }
        textField.text = ""
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    @objc func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherService.fetchWeather(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//WeatherManagerDelegate

extension WeatherViewController: WeatherServiceDelegate {
    func didFetchWeather(_weatherService: WeatherService, _ weather: WeatherModel) {
        updateUI(with: weather)
    }
    
    private func updateUI(with weatherModel: WeatherModel) {
        temperatureLabel.attributedText = makeTemperatureText(with: weatherModel.temperatureString)
                conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
                cityLabel.text = weatherModel.cityName
    }
    
}
