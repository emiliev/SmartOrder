//
//  CategoryViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/29/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var menu: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let productNib = UINib(nibName: "ProductCustomCell", bundle: nil)
        tableView.registerNib(productNib, forCellReuseIdentifier: "ProductCustomCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(menu != nil){
            return (menu?.categoryLength())!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "ProductCustomCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! ProductCustomCell
        let product = self.menu?.getProductAtIndex(indexPath.row)
        cell.getDataFromProduct(product)
        cell.selectionStyle = .None
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 95
    }

    @IBAction func orderButton(sender: AnyObject) {
        
        
    }
 
    @IBAction func addInStock(sender: AnyObject) {
        
        
    }
}
