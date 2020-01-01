//
//  ViewController.swift
//  Web Content
//
//  Created by Eric Cook on 10/26/14.
//  Copyright (c) 2014 Better Search, LLC. All rights reserved.
//

import UIKit
import CoreLocation
import WebKit

var manager = CLLocationManager()
var postalCode = String()
var zip2 = String()
var country = String()
var city = String()
var state = String()

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, WKUIDelegate
{
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var zip: UITextField!
    
    @IBAction func home(_ sender: AnyObject) {
        
        let myURL = URL(string:"https://www.wunderground.com/weather/us/ny/millwood/10546")
              let myRequest = URLRequest(url: myURL!)
        
        self.webView.load(myRequest)
       
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        city = ""
        state = ""
        country = ""
        postalCode = ""
        zip2 = ""
        
        zip2 = zip.text!
        
        print("Zip Code: \(zip2)")
        
        CLGeocoder().geocodeAddressString(zip2, completionHandler: {(placemarks, error) in
            
            if (error != nil) {
                
                print(error!)
                
            } else {
                
                let p = CLPlacemark(placemark: (placemarks?[0])! as CLPlacemark)
                
                //print(p)
                
                for (key, value) in p.addressDictionary! {
                    
                    print("\(key) -> \(value)")
                    
                    if "\(key)" == "ZIP" { postalCode = "\(value)"}
                    
                    if "\(key)" == "CountryCode" { country = "\(value)"}
                    
                    if "\(key)" == "City" { city = "\(value)"}
                    
                    if "\(key)" == "State" { state = "\(value)"}
                    
                    print("Location Details: \(country), \(state), \(city), \(postalCode)")
                    
                }
                
                let myURL = URL(string:"https://www.wunderground.com/weather/\(country)/\(state)/\(city)/\(zip2)")
                      let myRequest = URLRequest(url: myURL!)
                
                self.webView.load(myRequest)
                
            }
            
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0] 
        let latitude : CLLocationDegrees = userLocation.coordinate.latitude
        let longitude : CLLocationDegrees = userLocation.coordinate.longitude
        let alt = userLocation.altitude
        let speed = userLocation.speed
        let course = userLocation.course
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks, error) in
            
            if (error != nil) {
                
                print(error!)
            } else {
                
                let p = CLPlacemark(placemark: (placemarks?[0])! as CLPlacemark)
                
                let loc = "\(p.subThoroughfare!) \(p.thoroughfare!) \n\(p.locality!), \(p.administrativeArea!) \(p.postalCode!) \(p.country!)"
                
                postalCode = "\(p.postalCode!)"
                
                country = "\(p.country!)"
                
                city = "\(p.locality!)"
                
                state = "\(p.administrativeArea!)"
                
                print("Location Details: \(loc), \(latitude), \(longitude), \(alt), \(speed), \(course)")
                
            }
            
            
            
        })
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let alert = UIAlertController(title: "No Internet Connection!", message: "Please try again when you have an internet connection.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        print("Error: \(error)")
    }
    
    /*override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        self.webView.uiDelegate = self
        
        view = self.webView
    }*/
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        zip2 = ""
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        self.webView.scrollView.keyboardDismissMode = .onDrag
        
        //let defaults:NSUserDefaults = NSUserDefaults(suiteName: "group.bettersearchllc.Weather")!
        
        //defaults.setObject( postalCode , forKey: "zipCode")
        
    }
    
    @objc func getCurrentLocation() {
        
        zip2 = "\(postalCode)"
        
        print("Zip Code: \(zip2)")
        
        CLGeocoder().geocodeAddressString(zip2, completionHandler: {(placemarks, error) in
            
            if (error != nil) {
                
                print(error!)
                
            } else {
                
                let p = CLPlacemark(placemark: (placemarks?[0])! as CLPlacemark)
                
                for (key, value) in p.addressDictionary! {
                    
                    print("\(key) -> \(value)")
                    
                    if "\(key)" == "ZIP" { postalCode = "\(value)"}
                    
                    if "\(key)" == "CountryCode" { country = "\(value)"}
                    
                    if "\(key)" == "City" { city = "\(value)"}
                    
                    if "\(key)" == "State" { state = "\(value)"}
                    
                    print("Location Details: \(country), \(state), \(city), \(postalCode)")
                    
                }
                
                let myURL = URL(string:"https://www.wunderground.com/weather/\(country)/\(state)/\(city)/\(zip2)")
                let myRequest = URLRequest(url: myURL!)
                
                self.webView.load(myRequest)
                
            }
            
        })
    }
    
    func delay() {
        
        _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(getCurrentLocation), userInfo: nil, repeats: false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        delay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zip.resignFirstResponder()
        return true
    }
    
    
    
}
