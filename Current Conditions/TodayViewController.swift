//
//  TodayViewController.swift
//  Current Conditions
//
//  Created by Eric Cook on 11/6/14.
//  Copyright (c) 2014 Better Search, LLC. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

/*var postalCode1 = NSInteger()
var city = NSString()
var st = NSString()
var urlPath = NSString()*/

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    
    //@IBOutlet weak var weather: UILabel!
    
    //var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        weather.textColor = UIColor.grayColor()
        
        weather.text = "Updating the current \nweather conditions at \nyour location."*/
        
        //let defaults:NSUserDefaults = NSUserDefaults(suiteName: "group.bettersearchllc.Weather")!
        
        //postalCode1 = defaults.objectForKey("zipCode") as NSInteger
        
        //let tapGesture = UITapGestureRecognizer(target: self, action: "onTap:")
        
        //tapGesture.numberOfTapsRequired = 1
        
        //weather.userInteractionEnabled = true
        
        //weather.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func btn(sender: AnyObject) {
        
        let url:NSURL = NSURL(string: "Weather://")!
        extensionContext?.openURL(url, completionHandler: nil)
        
        
    }
    /*func onTap() {
        
        let url:NSURL = NSURL(string: "openApp://recent")!
        extensionContext?.openURL(url, completionHandler: nil)
        
    }*/

    
    /*func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as CLLocation
        
        var latitude : CLLocationDegrees = userLocation.coordinate.latitude
        
        var longitude : CLLocationDegrees = userLocation.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks, error) in
            
            if(error != nil) {
                
                println("Error: \(error)")
                
            } else {
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                var address = "\(p.subThoroughfare) \(p.thoroughfare) \n\(p.locality), \(p.administrativeArea) \(p.postalCode)"
                
                postalCode1 = p.postalCode.toInt()!
                city = p.locality
                st = p.administrativeArea
                if postalCode1 > 01000 && postalCode1 < 99999 {
                    
                    self.weather.textColor = UIColor.grayColor()
                    
                    urlPath = "http://api.wunderground.com/api/7ada8810c16329d6/conditions/q/\(postalCode1).json"
                    
                    self.weather.text = "Updating the current \nweather conditions at \n\(city), \(st) \(postalCode1)."
                    
                } else {
                    
                    postalCode1 = 10546
                    city = "Millwood"
                    st = "NY"
                    urlPath = "http://api.wunderground.com/api/7ada8810c16329d6/conditions/q/\(postalCode1).json"
                    
                    self.weather.textColor = UIColor.grayColor()
                    
                    self.weather.text = "Updating the current \nweather conditions at \n\(city), \(st) \(postalCode1)."
                    
                }
            }
            
        })
        manager.stopUpdatingLocation()
        
    }*/
    
    
    /*func locationManager(manager: CLLocationManager!, didFailWithError error: NSError) {
        
        println("Error: \(error)")
    }*/
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        
        /*postalCode1 = 10546
        
        let urlPath = "http://api.wunderground.com/api/7ada8810c16329d6/conditions/q/\(postalCode1).json"
        
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if (error != nil) {
                
                //completionHandler(.NewData)
                println("Error: \(error)")
                
            } else {
                
                let jsonResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                if let array: NSDictionary = jsonResult as? NSDictionary {
                    
                    if let co = array["current_observation"] as? NSDictionary {
                        
                        //let url_icon = co["icon_url"] as NSString
                        //let url_icon1:NSURL = NSURL(fileURLWithPath: "url_icon")!
                        //let imageData:NSData = NSData(contentsOfURL:url_icon1, options: nil, error: nil)!
                        //var icon = UIImage(data:imageData)
                        let cond = co["weather"] as NSString
                        let temp_f = co["temperature_string"] as NSString
                        let feelslike_f = co["feelslike_f"] as NSString
                        let wind_dir = co["wind_dir"] as NSString
                        let wind_mph = co["wind_gust_mph"] as NSString
                        let relative_humidity = co["relative_humidity"] as NSString
                        //self.icon.image = UIImage(data:imageData)
                        self.weather.textColor = UIColor.whiteColor()
                        self.weather.text = " Conditions in \(city), \(st) \(postalCode1):\n \(cond)\n Temp: \(temp_f)\n Feels Like: \(feelslike_f) F\n Wind: \(wind_mph) mph\n Direction: \(wind_dir)\n Humidity: \(relative_humidity)"
                        //self.radar.image = UIImage(data: data1)
                        
                    }
                }
                
            }
            
        })
        
        task.resume()
        
        manager.stopUpdatingLocation()*/
        
        completionHandler(NCUpdateResult.NoData)
        
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        let newInsets = UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left-15,
            bottom: defaultMarginInsets.bottom, right: defaultMarginInsets.right)
        return newInsets
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
