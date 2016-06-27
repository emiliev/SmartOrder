//
//  Order.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/27/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation

class Order{
    
    
    private var products: [Product] = []
    static let sharedInstance = Order()
    
    //preven cloning
    private init(){}
    
    func showOrderList() -> NSMutableDictionary{
        
        let orderList = NSMutableDictionary()
        for item in products{
            if (orderList.objectForKey(item.getDescription()) != nil){
                let newValue = (orderList[item.getDescription()] as! Int) + 1
                orderList[item.getDescription()] = newValue
            }
            else{
                orderList.setValue(1, forKey: item.getDescription())
            }
        }
        
        return orderList
    }
    
    func addProduct(newProduct: Product?) -> Bool{
        if(newProduct != nil){
            self.products.append(newProduct!)
            return true
        }
        return false
    }
    
    
}