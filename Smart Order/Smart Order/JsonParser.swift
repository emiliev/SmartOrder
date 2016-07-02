//
//  JsonParser.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/30/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation

class JsonParser{
    
    var data: NSData!
    init(withData: NSData){
        self.data = withData
    }

    
    func parse(){
        do {
            let json = try  NSJSONSerialization.JSONObjectWithData(self.data, options: .AllowFragments) as? NSDictionary
            print(json)
            NSNotificationCenter.defaultCenter().postNotificationName("SmartOrderMenu", object: json)
        }
        catch{
            print("Error serializing JSON \(error)")
        }
    }
}