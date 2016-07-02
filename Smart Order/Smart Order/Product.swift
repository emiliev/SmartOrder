//
//  Product.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/27/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation
class Product {
    
    private var name: String
    private var description: String
    private var ID: Int
    private var price: Float
    private var category: Int

    
    init(newName: String, newDescr: String, newID: Int, newPrice: Float, newCat: Int){
        self.name = newName
        self.description = newDescr
        self.ID = newID
        self.price = newPrice
        self.category = newCat
    }
    
    func getDescription() -> String{
        return self.description
    }
    
    func getID() -> Int{
        return self.ID
    }
    
    func getPrice() -> Float{
        return self.price
    }
    
    func getCategory() -> Int{
        return self.category
    }
 
    func getName() -> String{
        return self.name
    }
    
    static func productFromData(dict: NSDictionary) -> Product?{
        guard
            let _category       = Int((dict["category"] as? String)!),
            let _description    = dict["description"] as? String,
            let _id             = Int((dict["id"] as? String)!),
            let _name           = dict["name"] as? String,
            let _price          = Float((dict["price"] as? String)!)
        else{
            return nil
        }
        
        return Product(newName: _name, newDescr: _description, newID: _id, newPrice: _price, newCat: _category)
    }
}