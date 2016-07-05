//
//  HistoryViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 7/5/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var orderURL = "http://localhost/SmartOrder/Smart-Order-Services/api/orders.php?table="
    var tableURL = "http://localhost/SmartOrder/Smart-Order-Services/api/tables.php?name="
    var tableID: Int? = nil
    var orderdProducts: [(Int, Int)] = []
    var totalSum = 0.0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        let device_id = UIDevice.currentDevice().identifierForVendor?.UUIDString //table name
//        self.tableURL.appendContentsOf("second")
        let tempURL = self.tableURL + "second"
        // Do any additional setup after loading the view.
        print(tempURL)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let orderNib = UINib(nibName: "OrderCustomCell", bundle: nil)
        self.tableView.registerNib(orderNib, forCellReuseIdentifier: "OrderCustomCell")
        
        let totalNib = UINib(nibName: "TotalCustomCell", bundle: nil)
        self.tableView.registerNib(totalNib, forCellReuseIdentifier: "TotalCustomCell")
        
        let request = RequestManager(requestUrl: tempURL)
        request.getRequest()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HistoryViewController.update(_:)) , name: "SmartOrderMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HistoryViewController.loadOrder(_:)), name: "LoadOrder", object: nil)
        print("hello1234")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("hello")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return self.orderdProducts.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            if indexPath.section == 0{
                let cellID = "OrderCustomCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath:    indexPath) as? OrderCustomCell
                let curProduct = self.orderdProducts[indexPath.row]
                let productName = Menu.sharedInstance.getProductByID(curProduct.1)?.getName()
                //let productPrice = let productName = Menu.sharedInstance.getProductByID(curProduct.1)?.getPrice()
                cell?.productName.text = productName
                cell?.quantity.digit.text = "\(curProduct.0)"
                return cell!
        }
        let cellID = "TotalCustomCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? TotalCustomCell
        let digit = Float(self.totalSum)
        cell?.totalSum(digit)
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.orderdProducts.removeAll()
        self.totalSum = 0.0
    }

    // MARK: - Notifications
    
    func update(notification: NSNotification){
        let obj = notification.object as? NSDictionary
        if let data = obj!["data"] as? NSDictionary{
            if let table = data["table"] as? NSDictionary{
                self.tableID = Int(table["id"] as! String)!
                let tempOrderURL = self.orderURL + "\(self.tableID!)"
                let orderRequest = RequestManager(requestUrl: tempOrderURL)
                orderRequest.loadOrder()
            }
        }
    }
    
    func loadOrder(notification: NSNotification){
        let obj = notification.object as? NSDictionary
        if let data = obj!["data"] as? NSDictionary{
            if let ordersArray = data["orders"] as? NSArray {
                fetchOrders(ordersArray)
            }
        }
    }
   
    private func fetchOrders(ordersArray: NSArray){
        for order in ordersArray{
            print(order)
            if let dict = order as? NSDictionary{
                if let products = dict["products"] as? NSArray{
                    fetchProducts(products)
                }
            }
            let currentTax = order["total"] as? Double
            self.totalSum += currentTax!
        }
        self.tableView.reloadData()
    }
    
    private func fetchProducts(productArray: NSArray){
        for product in productArray{
            if let productDict = product as? NSDictionary{
                let productID = Int(productDict["product_id"] as! String)!
                let productQuantity = Int(productDict["quantity"] as! String)!
                let tuple = (productQuantity, productID)
                self.orderdProducts.append(tuple)
            }
        }
    }
}
