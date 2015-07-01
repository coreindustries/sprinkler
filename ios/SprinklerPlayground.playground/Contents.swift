//: Playground - noun: a place where people can play
import XCPlayground
import UIKit

//XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
XCPSetExecutionShouldContinueIndefinitely()

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

func test() {
    println("Start Test")
    let url = NSURL(string: "http://www.google.com")
    
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
    }
    
    task.resume()
}

test()








