//
//  ViewController.swift
//  Medly
//
//  Created by Jason Crispell on 2021-08-26.
//

import UIKit

// Add to github repo


// Show country name and capitol
// https://restcountries.eu/rest/v2/all

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let dataManager = DataManager()
    private var countries: [CountryObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    private let cellReuseId = "countryCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCountries()
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
    }
    
    
    func getCountries() {
        dataManager.getCountries { [weak self] countries, error in
            // Error processing
            if let countries = countries {
                self?.countries = countries
                // Update view
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        if countries.count > indexPath.row,
           let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellReuseId) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseId)
        }
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.capital
        return cell
    }
}

