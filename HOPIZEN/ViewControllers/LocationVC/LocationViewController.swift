//
//  LocationViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var path:String!
    var des: String!
    var category:CategoryModel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getCurrentAddress(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @IBAction func continues(_ sender: Any) {
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error) -> Void in
            if error {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func getAddress(latitude:CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation.init(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?.last
                let addressDic = pm?.addressDictionary
                var address:[String] = []
                let subAdministrativeArea = addressDic?["SubAdministrativeArea"] as? String ?? ""
                let name = addressDic?["Name"] as? String ?? ""
                let street = addressDic?["Street"] as? String ?? ""
                let state = addressDic?["State"] as? String ?? ""
                if(subAdministrativeArea.isEmpty == false) {
                    address.append(subAdministrativeArea)
                }
                if(name.isEmpty == false) {
                    address.append(name)
                }
                if(street.isEmpty == false) {
                    address.append(street)
                }
                if(state.isEmpty == false) {
                    address.append(state)
                }
                self.addressView.text = address.joined(separator: ", ")
            }
                
            else {
                print("Problem with the data received from geocoder")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.hasGetAddress = false
            }
        })
    }

    
    func displayLocationInfo(placemark: CLPlacemark) {
        if placemark != nil {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            println(placemark.locality ? placemark.locality : "")
            println(placemark.postalCode ? placemark.postalCode : "")
            println(placemark.administrativeArea ? placemark.administrativeArea : "")
            println(placemark.country ? placemark.country : "")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
    println("Error while updating location " + error.localizedDescription)
    }
}
