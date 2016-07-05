//
//  RequestManager.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/30/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class RequestManager: NSObject, NSURLSessionDelegate {
    
    let url: String
    init(requestUrl: String){
      self.url = requestUrl
    }
    
    func configSession(request: NSURLRequest){
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let task = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print(error)
                return
            }

            do {
                let json = try  NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                NSNotificationCenter.defaultCenter().postNotificationName("SmartOrderMenu", object: json)
            }
            catch{
                   print("Error serializing JSON \(error)")
            }
        }
        task.resume()
    }
    
    func postRequest(text: String){
        let request = NSMutableURLRequest(URL: NSURL(string: self.url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = text.dataUsingEncoding(NSUTF8StringEncoding)
        configSession(request)
    }
    
    func getRequest(){
        let request = NSURLRequest(URL: NSURL(string: self.url)!)
        configSession(request)
    }
    
    func loadOrder(){
        let request = NSURLRequest(URL: NSURL(string: self.url)!)
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        let task = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print(error)
                return
            }
            
            do {
                let json = try  NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary
                NSNotificationCenter.defaultCenter().postNotificationName("LoadOrder", object: json)
            }
            catch{
                print("Error serializing JSON \(error)")
            }
        }
        task.resume()
    }
    
}