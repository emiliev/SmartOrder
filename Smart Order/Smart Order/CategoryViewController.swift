//
//  CategoryViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/29/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var menu: Category? = nil
    var name: String? = nil
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.name
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.tableView.frame.size.height - width, width:  self.tableView.frame.size.width, height: self.tableView.frame.size.height)
        
        border.borderWidth = width
        self.tableView.layer.addSublayer(border)
        self.tableView.layer.masksToBounds = true
        
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
 
}
