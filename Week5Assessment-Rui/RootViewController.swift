//
//  ViewController.swift
//  Week5Assessment-Rui
//
//  Created by Rui Ong on 24/02/2017.
//  Copyright © 2017 Rui Ong. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RootViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        fetchAllStations()
    }
    
    func fetchAllStations(){
        let urlString = "https://feeds.citibikenyc.com/stations/stations.json"
        
        let url = URL(string: urlString)
        //        let defaultSession = URLSession(configuration: .default)
        
        //changing data to json
        Alamofire.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let stations = json["stationBeanList"].array {
                        for station in stations {
                            let newStation = BikeStation(json: station)
                            BikeStation.bikeStations.append(newStation)
                        }
                    }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
            
            print(BikeStation.bikeStations)
            self.listTableView.reloadData()
        }
    }
    
    
    
    @IBOutlet weak var listTableView: UITableView!
}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return BikeStation.bikeStations.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = BikeStation.bikeStations[indexPath.row].name
        cell.detailTextLabel?.text = String(BikeStation.bikeStations[indexPath.row].availableBikes)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mapPage = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {return}
        
        mapPage.indexPathRow = indexPath.row
        navigationController?.pushViewController(mapPage, animated: true)
        
    }
}

