//
//  DVMCityDetailsViewController.swift
//  AirQuality-C
//
//  Created by Ian Becker on 9/28/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class DVMCityDetailsViewController: UIViewController {

    // MARK: - Properties
    var country: String?
    var state: String?
    var city: String?
    
    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city,
            let state = state,
            let country = country
            else { return }
        
        DVMCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityDetails) in
            if let details = cityDetails {
                self.updateViews(with: details)
            }
        }
    }

    // MARK: - Class Methods
    func updateViews(with details: DVMCityAirQuality) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = "City: \(details.city)"
            self.stateLabel.text = "State: \(details.state)"
            self.countryLabel.text = " Country: \(details.country)"
            self.aqiLabel.text = "Air Quality Index: \(details.pollution.airQualityIndex)"
            self.windSpeedLabel.text = "Wind Speed: \(details.weather.windSpeed)"
            self.temperatureLabel.text = "Temperature: \(details.weather.temperature)"
            self.humidityLabel.text = "Humidity: \(details.weather.humidity)"
        }
    }
}
