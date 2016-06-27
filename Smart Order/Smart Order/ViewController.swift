//
//  ViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/27/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let order = Order.sharedInstance
        
        let product1 = Product(newDescr: "coca-cola", newID: 1, newPrice: 1.70, newCat: "Non-Alcohol")
        let product2 = Product(newDescr: "coca-cola", newID: 1, newPrice: 1.70, newCat: "Non-Alcohol")
        print(product1.getPrice(), product1.getCategory(), product1.getDescription(), product1.getID())
        
        order.addProduct(product1)
        order.addProduct(product2)
        
        print(order.showOrderList())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

