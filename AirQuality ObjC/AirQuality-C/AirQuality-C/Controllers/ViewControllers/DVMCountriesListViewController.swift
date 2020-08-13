//
//  DVMCountriesListViewController.swift
//  AirQuality-C
//
//  Created by Ian Becker on 8/12/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class DVMCountriesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var countries: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DVMCityAirQualityController.sharedInstance().fetchSupportedCountries { (countries) in
            DispatchQueue.main.async {
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DVMCountriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell") else {return UITableViewCell()}
        
        let country = DVMCityAirQualityController.sharedInstance().cityAirQualities[indexPath.row]
        
        cell.textLabel?.text = country.country
        
        return cell
    }
}
