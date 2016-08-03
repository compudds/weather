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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    @IBAction func btn(sender: AnyObject) {
       
        let url:NSURL = NSURL(string: "myweather://")!
        extensionContext?.openURL(url, completionHandler: nil)
        //UIApplication()sharedApplication openURL:[NSURL URLWithString:@"app://..."]
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
