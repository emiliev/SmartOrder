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
    
    //dict of table order
    func showOrderList() -> NSMutableDictionary{
        let orderList = NSMutableDictionary()
        for item in products{
            if (orderList.objectForKey(item.getName()) != nil){
                let newValue = (orderList[item.getName()] as! Int) + 1
                orderList[item.getName()] = newValue
            }
            else{
                orderList.setValue(1, forKey: item.getName())
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

    func removeProduct(productID: Int) -> Bool{
        for (index,item) in self.products.enumerate(){
            if item.getID() == productID{
                self.products.removeAtIndex(index)
                return true
            }
        }
        return false
    }
    
    func orderLength() -> Int{
        return self.products.count
    }
    
    func productAtIndex(index: Int) -> Product{
        return self.products[index]
    }
    
    func calculateBill() -> Float{
        var sum: Float = 0.0
        for item in products{
            sum += item.getPrice()
        }
        return sum
    }
    
    func prepareForOrder() -> NSArray{
        let orderList = NSMutableDictionary()
        for item in self.products{
            if(orderList.objectForKey(item.getID()) != nil){
                orderList[item.getID()] = (orderList[item.getID()] as! Int ) + 1
            }
            else{
                orderList[item.getID()] = 1
            }
        }
        
        var list: [NSDictionary] = []
        for elem in orderList{
            let tempProduct = NSMutableDictionary()
            let product_id = elem.key as? Int
            let quantity = elem.value as? Int
            tempProduct["product_id"] = product_id
            tempProduct["quantity"] = quantity
            list.append(tempProduct)
        }
        
        return list
    }

    
    
    /*
     
     let orderList = NSMutableDictionary()
     for item in products{
     if (orderList.objectForKey(item.getName()) != nil){
     let newValue = (orderList[item.getName()] as! Int) + 1
     orderList[item.getName()] = newValue
     }
     else{
     orderList.setValue(1, forKey: item.getName())
     }
     }
     return orderList
 */
    
    
}