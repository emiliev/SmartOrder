//
//  Category.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/29/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation

class Category{
    
    private var products:[Product] = []
    private var name: String
    init(newName: String){
        self.name = newName
    }
    
    func categoryLength() -> Int{
        return self.products.count
    }
    
    func addProduct(product: Product?) -> Bool{
        if(product != nil){
            self.products.append(product!)
            return true
        }
        return false
    }
    
    func getProductAtIndex(index: Int) -> Product?{
        if(index >= 0 && index < self.categoryLength()){
            let curProduct = self.products[index]
            return curProduct
        }
        return nil
    }
    
    func getProductByID(productId: Int) -> Product?{
        for item in self.products{
            if productId == item.getID(){
                return item
            }
        }
        return nil
    }
    
    func getName() -> String{
        return self.name
    }
    
    
}