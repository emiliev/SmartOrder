//
//  OrderViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 7/2/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let kSectionNumber = 2
    private let url = "http://localhost/SmartOrder/Smart-Order-Services/api/orders.php"
    var productNames = []
    var productQuantities = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let orderNib = UINib(nibName: "OrderCustomCell", bundle: nil)
        self.tableView.registerNib(orderNib, forCellReuseIdentifier: "OrderCustomCell")
        
        let totalNib = UINib(nibName: "TotalCustomCell", bundle: nil)
        self.tableView.registerNib(totalNib, forCellReuseIdentifier: "TotalCustomCell")
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let orderList = Order.sharedInstance.showOrderList()
        self.productNames = orderList.allKeys
        self.productQuantities = orderList.allValues
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - TableView
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
//        let product = Order.sharedInstance.productAtIndex(indexPath.row)
        if (indexPath.section == 0) {
            let cellID = "OrderCustomCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? OrderCustomCell
            cell?.productName.text = self.productNames[indexPath.row] as? String
            let quantity =  self.productQuantities.objectAtIndex(indexPath.row)
            cell?.quantity.digit.text = "\(quantity)"
            return cell!
        }
        else{
            
            let cellID = "TotalCustomCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? TotalCustomCell
            let sumToPay = Order.sharedInstance.calculateBill()
            cell?.totalSum(sumToPay)
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.productNames.count
        }
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return kSectionNumber
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "" : "Bill"
    }
    
    @IBAction func makeOrder(sender: AnyObject) {
    
        if(self.productNames.count == 0){
            showAlert("No products to order")
        }else{
            
            //device id : >
            let result = NSMutableDictionary()
            let table_id = UIDevice.currentDevice().identifierForVendor?.UUIDString
            let dict = Order.sharedInstance.prepareForOrder()
            
            result["table_id"] = 2 // WTF :D ?
            result["products"] = dict
            do{
                let jsonData = try NSJSONSerialization.dataWithJSONObject(result, options: .PrettyPrinted)
                let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
                let request = RequestManager(requestUrl: url)
                request.postRequest(jsonString)
            }
            catch let error as NSError{
                print(error)
            }
            
            clearData()
            showAlert("Successfully ordered!")
        }
    }
    
    func clearData(){
        Order.sharedInstance.clearCurrentOrder()
        self.productNames = []
        self.productQuantities = []
        self.tableView.reloadData()
    }
    
    func showAlert(text: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
