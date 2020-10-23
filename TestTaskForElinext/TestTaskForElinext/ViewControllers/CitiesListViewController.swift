//
//  ViewController.swift
//  TestTaskForElinext
//
//  Created by Batman on 10/20/20.
//

import UIKit

class CitiesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityInformationTextViewContainerView: UIView!
    @IBOutlet weak var cityInformationTextViewContainerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cityInformationTextView: UITextView!
    @IBOutlet weak var moveToMapViewController: UIButton!

    var isScaled = false
    var citiesArray:[City] = UserDefaultsManager.shared.loadData()
    
    //MARK: - Main Functions
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overrideUserInterfaceStyle = .light
        addTapOnCityInformationTextViewContainerView()
    }
    
    //MARK: - IBActions
    
    @IBAction func moveToMapViewControllerIsPressed(_ sender: UIButton) {
        if let viewController = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController {
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func resizeCityInformationTextViewContainerView() {
        if !cityInformationTextView.text.isEmpty {
            if !isScaled {
                changeSizeOfCityInformationTextViewContainerView()
            } else {
                changeSizeOfCityInformationTextViewContainerView()
            }
        }
    }
    
    //MARK: - Flow Functions
    
    func addTapOnCityInformationTextViewContainerView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(resizeCityInformationTextViewContainerView))
        cityInformationTextViewContainerView.addGestureRecognizer(tap)
    }
    
    func changeSizeOfCityInformationTextViewContainerView() {
        if !isScaled {
            animateConstraint(multiplier: 0.60)
        } else {
            animateConstraint(multiplier: 1/3)
        }
        isScaled.toggle()
    }
    
    func animateConstraint(multiplier: CGFloat) {
        cityInformationTextViewContainerViewHeightConstraint = cityInformationTextViewContainerViewHeightConstraint.constraintWithMultiplier(multiplier)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func receivingNewData(itemIndex: Int) {
        self.view.isUserInteractionEnabled = false
        cityInformationTextView.text = "Loading info..."
        citiesArray[itemIndex].temperatureAndWeatherRefreshDate = Date()
        getNewDataIn(item: citiesArray[itemIndex], itemIndex: itemIndex)
    }
    
    func getNewDataIn(item: City, itemIndex: Int) {
        NetworkService.shared.getCurrentTemperatureAndWeatherInfoFromCityName(city: item) { (city) in
            self.citiesArray[itemIndex] = city
            DispatchQueue.main.async {
                self.tableView.reloadData()
                UserDefaultsManager.shared.saveData(self.citiesArray)
                self.putCityInfoInTextView(item: city)
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func putCityInfoInTextView(item: City) {
        if let description = item.cityDescription, let currentTemperatureAndWeatherDescription = item.currentTemperatureAndWeatherDescription {
            cityInformationTextView.text =  """
                                            \(description)
                                            \(currentTemperatureAndWeatherDescription)
                                            """
        }
    }

}

//MARK: - Extensions

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.fillInTheCell(item: citiesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if citiesArray[indexPath.row].temperatureAndWeatherRefreshDate == nil {
            receivingNewData(itemIndex: indexPath.row)
        } else {
            let currentDate = Date()
            if let previousDate = citiesArray[indexPath.row].temperatureAndWeatherRefreshDate {
                if previousDate.addingTimeInterval(3600) < currentDate {
                    receivingNewData(itemIndex: indexPath.row)
                } else {
                    putCityInfoInTextView(item: citiesArray[indexPath.row])
                }
            }
        }
    }
    
}

extension CitiesListViewController: UpdateTextFieldWithCurrentDataDelegate {
    
    func updateTextField(text: String) {
        cityInformationTextView.text = text
    }
    
}
