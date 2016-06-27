//
//  Product.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/27/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation
class Product {
    
    private var description: String
    private var ID: Int
    private var price: Float
    private var category: String

    
    init(newDescr: String, newID: Int, newPrice: Float, newCat: String){
        
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
    
    func getCategory() -> String{
        return self.category
    }
    
}