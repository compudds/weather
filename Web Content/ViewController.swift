//
//  ViewController.swift
//  Web Content
//
//  Created by Eric Cook on 10/26/14.
//  Copyright (c) 2014 Better Search, LLC. All rights reserved.
//

import UIKit
import CoreLocation

var manager = CLLocationManager()
var postalCode = NSString()
var zip2 = NSString()


class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate
   {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var weather: UILabel!
    
    
    
    @IBAction func home(sender: AnyObject) {
        
        /*var alert = UIAlertController(title: "Alert", message: "Do you want to switch to the Weather App?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                let url:NSURL = NSURL(string: "openApp://recent")!
                self.extensionContext?.openURL(url, completionHandler: nil)
                
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
        }))*/
        
        
        let url1 = NSURL(string: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=\(zip2)#location")
        
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url1!) {(data1, response, error) in
            
            _ = NSString (data: data1!, encoding: NSUTF8StringEncoding)
            
            let request1 = NSURLRequest(URL: url1!)
            
            self.webView.loadRequest(request1)
            
        }
        
        task.resume()

        
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        let zip1:Int? = Int(zip.text!)
        if (zip1 != nil && (zip1 >= 01000 && zip1 <= 99999)) {
            
            weather.text = "Your weather at \(zip1!) is:"
            
            let url = NSURL(string: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=\(zip1!)#location")
            
            print(url!)
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                
                _ = NSString (data: data!, encoding: NSUTF8StringEncoding)
                
                /*if webAddress!.containsString("<div class=\"wx-24hour wx-module wx-grid3of6 wx-weather\">") {
                
                var contentArray = webAddress!.componentsSeparatedByString("<div class=\"wx-24hour wx-module wx-grid3of6 wx-weather\">")
                
                var newContentArray = contentArray[1].componentsSeparatedByString("</li></ul></div>")
                
                var weatherForcast: AnyObject = newContentArray[0]*/
                
                
                //self.weather.text = weatherForcast
                
                
                let request = NSURLRequest(URL: url!)
                
                //self.weather.text = weatherForcast as? String
                
                //println(self.weather.text)
                self.webView.loadRequest(request)
                //}
            }
            
            task.resume()
            
            
            
        } else {
            if zip1 == nil {
                zip2 = "\(postalCode)"
                print("\(postalCode)")
                
                weather.text = "Your weather at \(zip2) is: "
                
                let url1 = NSURL(string: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=\(zip2)#location")
                
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(url1!) {(data1, response, error) in
                    
                    _ = NSString (data: data1!, encoding: NSUTF8StringEncoding)
                    
                    let request1 = NSURLRequest(URL: url1!)
                    
                    self.webView.loadRequest(request1)
                    
                }
                
                task.resume()

            } else {
            self.weather.text = "Please enter a valid US Zip Code."
            }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //println("locations = \(locations)")
        
        let userLocation:CLLocation = locations[0] 
        
        //41.192644, -73.813008 = 39 Taconic Rd. Millwood, NY
        let latitude : CLLocationDegrees = userLocation.coordinate.latitude
        let longitude : CLLocationDegrees = userLocation.coordinate.longitude
        let alt = userLocation.altitude
        let speed = userLocation.speed
        let course = userLocation.course
        //var distance = userLocation.distanceFromLocation(userLocation)
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler:{(placemarks, error) in
            
            if(error != nil) {
                print(error)
            } else {
                //println(placemarks)
                let p = CLPlacemark(placemark: (placemarks?[0])! as CLPlacemark)
                let loc = "\(p.subThoroughfare!) \(p.thoroughfare!) \n\(p.locality!), \(p.administrativeArea!) \(p.postalCode!) "
                postalCode = "\(p.postalCode!)"
                print("Location Details: \(loc), \(latitude), \(longitude), \(alt), \(speed), \(course)")
                
                    
                
            }
                
            
            
        })
        //println("\(postalCode)")
        /*let latDelta:CLLocationDegrees = 0.03
        let longDelta:CLLocationDegrees = 0.03
        var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        
        annotation.title = "\(latitude), \(longitude),"
        
        annotation.subtitle = "\(altitude), \(course), \(speed)"
        
        println("\(latitude), \(longitude), \(altitude), \(course), \(speed)")
        
        mapView.addAnnotation(annotation)
        
        var userPin = UILongPressGestureRecognizer(target: self, action: "action:")
        
        userPin.minimumPressDuration = 1.0
        
        mapView.addGestureRecognizer(userPin)*/
       
        
    }
    
   
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "No Internet Connection!", message: "Please try again when you have an internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        print("Error: \(error)")
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        zip2 = ""
        
        manager = CLLocationManager()
       
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
        
        //let defaults:NSUserDefaults = NSUserDefaults(suiteName: "group.bettersearchllc.Weather")!
        
        //defaults.setObject( postalCode , forKey: "zipCode")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if(zip2 == "") {
            zip2 = "\(postalCode)"
            print("Zip Code: \(postalCode)")
            
            self.weather.text = "Your weather at \(zip2) is: "
            
            let url1 = NSURL(string: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=\(zip2)#location")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url1!) {(data1, response, error) in
                
                _ = NSString (data: data1!, encoding: NSUTF8StringEncoding)
                
                let request1 = NSURLRequest(URL: url1!)
                
                self.webView.loadRequest(request1)
                
            }
            
            task.resume()
            
        } else{
            zip2 = "10546"
            //println("\(self.postalCode)")
            
            self.weather.text = "Your weather at \(zip2) is: "
            
            let url1 = NSURL(string: "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=\(zip2)#location")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url1!) {(data1, response, error) in
                
                _ = NSString (data: data1!, encoding: NSUTF8StringEncoding)
                
                let request1 = NSURLRequest(URL: url1!)
                
                self.webView.loadRequest(request1)
                
            }
            
            task.resume()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        zip.resignFirstResponder()
        return true
    }
    


}

