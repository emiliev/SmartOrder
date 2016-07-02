//
//  ProductCustomCell.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/29/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class ProductCustomCell: UITableViewCell {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!

    private var oldValue = 0
    private var productID = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        oldValue = Int(self.stepper.value)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeQuantity(sender: AnyObject) {
        let currentOrder = Order.sharedInstance
        let value = Int(self.stepper.value)
        //Remove product from order
        if(self.oldValue > value){
            if(currentOrder.removeProduct(self.productID)){
                print("deleted product from order list")
            }
            
        }
        //Add product in order list
        else{
            let menu = Menu.sharedInstance
            let curProduct = menu.getProductByID(self.productID)
            if(currentOrder.addProduct(curProduct)){
                print("added product in order list")
            }
        }
        self.oldValue = value
        self.productQuantity.text = "\(value)"
    }

    func getDataFromProduct(product: Product?){
        
        self.productNameLabel.text = product!.getName()
        self.productDescriptionLabel.text = product!.getDescription()
        self.productPrice.text = "Price: \(product!.getPrice())$"
        self.productID = (product?.getID())!
    }
}
