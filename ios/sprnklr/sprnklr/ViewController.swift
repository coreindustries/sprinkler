//
//  ViewController.swift
//  sprnklr
//
//  Created by Corey Szopinski on 7/1/15.
//  Copyright (c) 2015 Corey Szopinski. All rights reserved.
//

import UIKit


// HANDLE OUR DATE FORMATTING FROM PARTICLE
//  "2015-07-01T22:34:36.806Z"
// http://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object
extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
//        println(d)
        self.init(timeInterval:0, sinceDate:d)
    }
}





class ViewController: UIViewController {

    var current_status : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("--- initial load, checking status ---")
        getParticleVariable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var buttonText: UIButton!

    @IBAction func handleButton(sender: UIButton) {
//        println("press")
        
        
        var param = "off"
        
        if(current_status == false){
            param = "on"
//            buttonText.setTitle("Turn Off", forState: UIControlState())
            current_status = true
        }else{
            param = "off"
//            buttonText.setTitle("Turn On", forState: UIControlState())
            current_status = false
        }
        
        println("--- button pressed ---")
        updateButton()
//        println("------ \(param)")
        self.post(param, url: "https://api.particle.io/v1/devices/2e003d000647343232363230/led")
    }
    
    
    func updateButton(){
        println("\nupdateButton() \(current_status)")
        println("scope? \(buttonText.titleLabel!.text)")
//        NSLog("scope %@",buttonText.titleLabel!.text!)
        if(current_status == false){
            buttonText.setTitle("Turn On", forState: UIControlState())
        }else{
            buttonText.setTitle("Turn Off", forState: UIControlState())
        }
        println("scope? \(buttonText.titleLabel!.text)")
    }
    
    
    // http://jamesonquave.com/blog/making-a-post-request-in-swift/
    // http://stackoverflow.com/questions/24068866/perform-post-request-in-swift
    
    func post(params : String, url : String) {
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        var err: NSError?
        var dataString = "access_token=8cc6b1af1b0cf053047f51bec0deb6a85e3e24ff&args="
        dataString += params
        let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        request.HTTPBody = data
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
//                    println("Succes: \(success)")
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        
        task.resume()
    }
    
    
    /*
    GET AN UPDATE FROM PARTICLE. IS IT ON OR OFF
    set our button text accordingly
    */
    func getParticleVariable() {
        
        var url = "https://api.particle.io/v1/devices/2e003d000647343232363230/status?access_token=8cc6b1af1b0cf053047f51bec0deb6a85e3e24ff"
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        var err: NSError?
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
//            println("Header: \(response)")
//            println("Body: \(strData)")
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
             //println("JSON: \(json)")
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var connected = parseJSON["result"] as? Int
                    var variable_name = parseJSON["name"] as? String
                    var result = parseJSON["result"] as? Int
                    println("PHOTON STATUS \(result)")
                    if(result == 1){
                        println("--- ON ---")
                        self.current_status = true
                    }else if(result == 0){
                        println("--- OFF ---")
                        self.current_status = false
                    }
                    
                    
                    if let parseCoreInfo: AnyObject = parseJSON["coreInfo"] {
                        var connected = parseCoreInfo["connected"] as? Int
                        var deviceID = parseCoreInfo["deviceID"] as? String
                        var last_handshake_at = parseCoreInfo["last_handshake_at"] as? String
                        var last_handshake_date = NSDate(dateString:last_handshake_at!)
                        var last_heard = parseCoreInfo["last_heard"] as? String
                        var last_heard_date = NSDate(dateString:last_heard!)
//                        println("last handshake: \(last_handshake_date.timeIntervalSinceNow)")
//                        println("last heard: \(last_heard_date.timeIntervalSinceNow)")
//                        println(deviceID!)
                    }
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
        })
        self.updateButton()
        task.resume()
    }
    
}

