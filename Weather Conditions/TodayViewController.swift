//
//  TodayViewController.swift
//  Weather Conditions
//
//  Created by Eric Cook on 12/17/14.
//  Copyright (c) 2014 Better Search, LLC. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var weather: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var percip: UILabel!
    @IBOutlet var PercipInch: UILabel!
    
    func prices() {
        
        if let url3 = URL(string: "https://www.wunderground.com/weather/us/ny/millwood/10546#location") {
            
            do {
                
                let contents3 = try String(contentsOf: url3)
                let matched3 = matches(for: "<span _ngcontent-c.+=\"\" class=\"wu-value wu-value-to\" style=\"\">.+", in: contents3)
                
                let snippet3 = "\(matched3)" //[0]
                
                let indexStartOfText3 = snippet3.index(snippet3.startIndex, offsetBy: 67)
                let indexEndOfText3 = snippet3.index(snippet3.endIndex, offsetBy: -668) //-944 814
                
                let substring3 = snippet3[indexStartOfText3..<indexEndOfText3]
                
                var matchedTemp = matches(for: "[0-9]", in: String(substring3))
                
                if (matchedTemp.count == 3) {
                    
                    let matchedTemp1 = matchedTemp[0] + matchedTemp[1] + matchedTemp[2]
                    self.temp.text = "Millwood Temp: \(matchedTemp1)\u{00B0}F"
                    
                } else {
                    
                    let matchedTemp1 = matchedTemp[0] + matchedTemp[1]
                    self.temp.text = "Millwood Temp: \(matchedTemp1)\u{00B0}F"
                    
                }
                
                
                let forcast = matches(for: "<a _ngcontent-c.+=\"\" class=\"module-link\">.+<", in: contents3)
                
                let snippet4 = "\(forcast)" //[0]
                
                let indexStartOfText4 = snippet4.index(snippet4.startIndex, offsetBy: 46)
                let indexEndOfText4 = snippet4.index(snippet4.endIndex, offsetBy: -195) //-191 -3
                
                let substring4 = snippet4[indexStartOfText4..<indexEndOfText4]
                var substring41 = "\(substring4)"
                substring41 = substring41.replacingOccurrences(of: ">", with: "", options: .literal, range: nil)
                
                if let dotRange = substring41.range(of: "<") {
                    substring41.removeSubrange(dotRange.lowerBound..<substring41.endIndex)
                }
                
                 self.weather.text = "\(substring41)"
                
                let percip = matches(for: "<a _ngcontent-c.+=\"\" class=\"hook\">.+", in: contents3)
                
                var snippet5 = "\(percip)" //[0]
                //Deletes everything after %
                if let matchedPercip2 = snippet5.range(of: "%") {
                    snippet5.removeSubrange(matchedPercip2.lowerBound..<snippet5.endIndex)
                }
                
                //Deletes the first 34 char
                let indexStartOfText5 = snippet5.index(snippet5.startIndex, offsetBy: 34)
                //let indexEndOfText5 = snippet5.index(snippet5.endIndex, offsetBy: -108) //-91 -11
                
                let substring5 = snippet5[indexStartOfText5...]  //<indexEndOfText5]
                var substring51 = "\(substring5)"
                substring51 = substring51.replacingOccurrences(of: "-c..", with: "-c", options: .regularExpression, range: nil)
                
                
                var matchedPercip = matches(for: "[0-9]", in: String(substring51))
                
                if (matchedPercip.count == 3) {
                    
                    let matchedPercip1 = matchedPercip[0] + matchedPercip[1] + matchedPercip[2]
                    self.percip.text = "Percip: \(matchedPercip1)%, "
                    
                } else {
                    
                    if (matchedPercip.count == 2) {
                        
                        let matchedPercip1 = matchedPercip[0] + matchedPercip[1]
                        self.percip.text = "Percip: \(matchedPercip1)%, "
                        
                    } else {
                        
                        if (matchedPercip.count == 1) {
                            
                            let matchedPercip1 = matchedPercip[0]
                            self.percip.text = "Percip: \(matchedPercip1)%, "
                            
                        }
                        
                    }
                    
                }
              
                let percipInch = matches(for: "<span _ngcontent-c.+=\"\" class=\"wu-value wu-value-to\" style=\"\">.+", in: contents3)
                
                var snippet6 = "\(percipInch[3])"  //[2]
                
                if let matchedPercip3 = snippet6.range(of: "</") {
                    snippet6.removeSubrange(matchedPercip3.lowerBound..<snippet6.endIndex)
                }
                
                let indexStartOfText6 = snippet6.index(snippet6.startIndex, offsetBy: 62) //401 324
                //let indexEndOfText6 = snippet6.index(snippet6.endIndex, offsetBy: -561) //-262 -53
                
                let substring6 = snippet6[indexStartOfText6...]//<indexEndOfText6]
                //var substring61 = "\(substring6)"
                //substring61 = substring61.replacingOccurrences(of: "-c..", with: "-c", options: .regularExpression, range: nil)
                
                
                var matchedPercipInch = matches(for: "[0-9]", in: String(substring6))
                
                if (matchedPercipInch.count == 3) {
                    
                    let matchedPercipInch1 = matchedPercipInch[0] + "." + matchedPercipInch[1] + matchedPercipInch[2]
                    self.PercipInch.text = "\(matchedPercipInch1) inches"
                    
                } else {
                    
                    if (matchedPercipInch.count == 2) {
                        
                        let matchedPercipInch1 = matchedPercipInch[0] + "." + matchedPercipInch[1]
                        self.PercipInch.text = "\(matchedPercipInch1) inches"
                        
                    } else {
                        
                        if (matchedPercipInch.count == 1) {
                            
                            let matchedPercipInch1 = matchedPercipInch[0]
                            self.PercipInch.text = "\(matchedPercipInch1) inch"
                            
                        }
                        
                    }
                    
                }
                
            } catch {
                // contents could not be loaded
                self.weather.text = "We could not get the current temperature."
            }
        } else {
            // the URL was bad!
            self.weather.text = "We could not connect to Weather Underground."
        }
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        //_ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(TodayViewController.prices), userInfo: nil, repeats: true)
        
        prices()

       if #available(iOS 10.0, *) {
           self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
       } else {
           // Fallback on earlier versions
       }
 
   }
    
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize){
        //if #available(iOSApplicationExtension 10.0, *) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize;
        }
        else {
            self.preferredContentSize = CGSize(width: 0, height: 176);
        }
        // } else {
        // Fallback on earlier versions
        // }
    }
    
    
    @IBAction func btn(_ sender: AnyObject) {
       
        let url:URL = URL(string: "myweather://")!
        extensionContext?.open(url, completionHandler: nil)
        //UIApplication()sharedApplication openURL:[NSURL URLWithString:@"app://..."]
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.newData)
    }
    
}

