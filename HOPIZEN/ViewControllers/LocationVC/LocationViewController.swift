//
//  LocationViewController.swift
//  PublicEyes
//
//  Created by Hung Hoang on 5/20/17.
//  Copyright © 2017 Hoang Ngoc Hung. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var path:String!
    var des: String!
    var category:CategoryModel!
    var locationStr:String?
    var district:String?
    var province:String?
    
    @IBOutlet weak var tvLocation: UITextField!
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
        let params = NSMutableDictionary.init();
        params.setObject(category.name ?? "", forKey: "category_id" as NSCopying)
        params.setObject(category.id ?? 0,forKey: "category_name" as NSCopying)
        params.setObject(path ?? "", forKey: "path" as NSCopying)
        params.setObject(locationStr ?? "",forKey: "location" as NSCopying)
        params.setObject(district ?? "", forKey: "district" as NSCopying)
        params.setObject(province ?? "",forKey: "province" as NSCopying)
        params.setObject(tvLocation.text ?? "",forKey: "address" as NSCopying)
        params.setObject(userDefault.string(forKey: UserDefault_email) ?? "",forKey: "email" as NSCopying)
        params.setObject(des ?? "",forKey: "desciption" as NSCopying)
        //params.setObject(time) ?? "",forKey: "create_date" as NSCopying)
        
        HPZWebservice.shareInstance.updateComplaint(path: API_UPDATE_COMPLAINT, params: params, handler:{success , response in
            if(success) {
                if(response?.isKind(of: HPZMessageModel.self))!{
                    let message:HPZMessageModel = response as! HPZMessageModel
                    if(message.code == 0) {
                        return
                    } else {
                        let alert = UIAlertController(title: "Alert", message: message.message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            let alert = UIAlertController(title: "Alert", message: "Kết nối server thất bại", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, entity: HPZMessageModel())
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                self.locationStr = String.init(manager.location!.coordinate.latitude) + "," + String.init(manager.location!.coordinate.longitude)
                let pm = placemarks?.last
                self.displayLocationInfo(placemark: pm!)
            } else {
                print("Problem with the data received from geocoder")
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
                self.tvLocation.text = address.joined(separator: ", ")
            }
                
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    
    func displayLocationInfo(placemark: CLPlacemark) {
        //stop updating location to save battery life
        locationManager.stopUpdatingLocation()
        let addressDic = placemark.addressDictionary
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
            self.district = street
            address.append(street)
        }
        if(state.isEmpty == false) {
            self.province = state
            address.append(state)
        }
        self.tvLocation.text = address.joined(separator: ", ")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
}
