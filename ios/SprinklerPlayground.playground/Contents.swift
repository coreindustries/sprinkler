//: Playground - noun: a place where people can play
import XCPlayground
import UIKit

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
//XCPSetExecutionShouldContinueIndefinitely()

//
//var str = "Hello, playground"
//print(str)
//
//let url = NSURL(string: "http://google")
//
//let session = NSURLSession.sharedSession()

//let dataTask = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response:NSURLResponse!,error: NSError!) -> Void in
//    //do something
//    print(data)
//    print(response)
//    
//})

//var url : NSURL = NSURL(string: "https://google.com")!
//var request: NSURLRequest = NSURLRequest(URL: url)
//let config = NSURLSessionConfiguration.defaultSessionConfiguration()
//let session = NSURLSession(configuration: config)
//
//let task : NSURLSessionDataTask = session.dataTaskWithRequest(url, completionHandler: {(data, response, error) in
//    
//    // notice that I can omit the types of data, response and error
//    
//    // your code
//    
//});

//let urlPath = "http://google.com"
//let url = NSURL(string: urlPath)
//let session = NSURLSession.sharedSession()
//let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//    println("Task completed")
//    if(error != nil) {
//        // If there is an error in the web request, print it to the console
//        println(error.localizedDescription)
//        print(data)
//        print(response)
//        
//}
//    var err: NSError?
//    
//    var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
//    if(err != nil) {
//        // If there is an error parsing JSON, print it to the console
//        println("JSON Error \(err!.localizedDescription)")
//    }
//    let results: NSArray = jsonResult["results"] as! NSArray
//    print(results)
//
//})
//
//let google = NSURL(string: "http://www.google.com")
//
//let task = NSURLSession.sharedSession().dataTaskWithURL(google!) {(data, response, error) in
//    println(NSString(data: data, encoding: NSUTF8StringEncoding))
//    println(response.debugDescription)
//    println(response.URL)
//    println(response)
//    println(response[1].headers)
//    
//}
//
//task.resume()
//
//
//let urlPath: String = "http://www.google.com"
//
//
//var url: NSURL = NSURL(string: urlPath)!
//var request1: NSURLRequest = NSURLRequest(URL: url)
//
//var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
//var error: NSErrorPointer = nil
//var dataVal: NSData = NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
//var err: NSError
//
//println(response)
//
//
//var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
//println("Synchronous\(jsonResult)")


//let url = "http://google.com"
//
//var request:NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
//
//NSOperationQueue.mainQueue().cancelAllOperations()
//
//NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
//    (response:NSURLResponse!, imageData:NSData!, error:NSError!) -> Void in
//    
////    cell?.catImageView?.image = UIImage(data: imageData)
//    
//})


//let url = NSURL(string: "http://www.google.com")
//let request = NSURLRequest.init(URL: NSURL(string: "http://www.google.com"))
//let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
//    (data, response, error) in
//    println(NSString(data: data, encoding: NSUTF8StringEncoding))
//}
//
//task.resume()


//Uncomment both lines below if testing on an Xcode playground.
//import XCPlayground
//XCPSetExecutionShouldContinueIndefinitely()

//func test() {
//    println("Start Test")
//    let url = NSURL(string: "http://www.google.com")
//    
//    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//        println(NSString(data: data, encoding: NSUTF8StringEncoding))
//    }
//    
//    task.resume()
//}
//
//test()


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
        
//        println(data)
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
//        var id = strData?.id
        
        println("Header: \(response)")
        println("Body: \(strData)")
        
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
        
        println("JSON: \(json)")
        
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
                var connected = parseJSON["connected"] as? Int
                var id = parseJSON["id"] as? String
                var return_value = parseJSON["return_value"] as? Int
                println("connected: \(connected!)")
                println("id: \(id!)")
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

var param = "on"
//post(param,"https://api.particle.io/v1/devices/2e003d000647343232363230/led")



// http://stackoverflow.com/questions/24089999/how-do-you-create-a-swift-date-object
extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
//        var dateString = "2015-07-01T22:34:36.806Z"
//        dateStringFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        println(d)
        self.init(timeInterval:0, sinceDate:d)
    }
}

//var junkDate = NSDate(dateString:"2015-07-01T22:34:36.806Z")
//var junkDate = NSDate(dateString:"2015-07-01T22:34:36.806Z")
//println(junkDate)



func get() {
    
    var url = "https://api.particle.io/v1/devices/2e003d000647343232363230/status?access_token=8cc6b1af1b0cf053047f51bec0deb6a85e3e24ff"
    
    var request = NSMutableURLRequest(URL: NSURL(string: url)!)
    var session = NSURLSession.sharedSession()
    var err: NSError?

    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
        
        //        println(data)
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        //        var id = strData?.id
        
        println("Header: \(response)")
        println("Body: \(strData)")
        
        var err: NSError?
        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
        
        println("JSON: \(json)")
        
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
                if(result == 1){
                    println("--- ON ---")
                }else if(result == 0){
                    println("--- OFF ---")
                }
                
                if let parseCoreInfo: AnyObject = parseJSON["coreInfo"] {
                    var connected = parseCoreInfo["connected"] as? Int
                    var deviceID = parseCoreInfo["deviceID"] as? String
                    var last_handshake_at = parseCoreInfo["last_handshake_at"] as? String
                    var last_handshake_date = NSDate(dateString:last_handshake_at!)
                    var last_heard = parseCoreInfo["last_heard"] as? String
                    var last_heard_date = NSDate(dateString:last_heard!)
                    println("last handshake: \(last_handshake_date.timeIntervalSinceNow)")
                    println("last heard: \(last_heard_date.timeIntervalSinceNow)")
                    println(deviceID!)
                }
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

get()








