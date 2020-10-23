//
//  MapViewController.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/22/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
 
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showWeatherOnCurrentCoordsButton: UIButton!
    
    var delegate:UpdateTextFieldWithCurrentDataDelegate?
    
    //MARK: - IBActions
    @IBAction func showWeatherOnCurrentCoordsButtonIsPressed(_ sender: UIButton) {
        prepareDataToReturn()
    }
    
    //MARK: - Flow Functions
    
    func prepareDataToReturn() {
        self.view.isUserInteractionEnabled = false
        showWeatherOnCurrentCoordsButton.setTitle("Loading. Please wait", for: .normal)
        let latitude = String(mapView.centerCoordinate.latitude)
        let longtitutde = String(mapView.centerCoordinate.longitude)
        NetworkService.shared.getCurrentTemperatureAndWeatherInfoFromGeocoords(latitude: latitude, longtitude: longtitutde) { (textToReturn) in
            DispatchQueue.main.async {
                self.delegate?.updateTextField(text: textToReturn)
                self.navigationController?.popViewController(animated: true)
                self.view.isUserInteractionEnabled = true
            }
        }
    }

}
