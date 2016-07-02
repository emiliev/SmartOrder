//
//  Menu.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/29/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import Foundation

class Menu{
    var categories: [Category]
    static let sharedInstance = Menu()
    
    private init(){
        self.categories = [Category]()
    }
    
    func categoryAtIndex(index: Int) -> Category?{
        if(index >= 0 && index < self.categories.count){
            let curCat = self.categories[index]
            return curCat
        }
        return nil
    }
    
    func addCategory(newCat: Category?) -> Bool{
        if(newCat != nil){
            self.categories.append(newCat!)
            return true
        }
        return false
    }
    
    func menuLength() -> Int{
        return self.categories.count
    }
    
    func createMenu(data: NSDictionary){
        let menu = data["products"] as? NSArray
        for item in menu!{
            let menuItem = Product.productFromData(item as! NSDictionary)
            let categoryNumber = (menuItem?.getCategory())!
            while (self.menuLength() <= categoryNumber){
                let newCategory = Category(newName: "Test")
                self.addCategory(newCategory)
            }
            self.categories[categoryNumber].addProduct(menuItem)
        }
    }
    
    func getProductByID(productID: Int) -> Product?{
        for cat in self.categories{
            let product = cat.getProductByID(productID)
            if(product != nil){
                return product!
            }
        }
        return nil
    }
    
}



