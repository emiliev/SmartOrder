//
//  ViewController.swift
//  Smart Order
//
//  Created by Emil Iliev on 6/27/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSURLSessionDelegate{

    let url = "https://cryptic-mountain-25848.herokuapp.com/api/products.php"
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let request = RequestManager(requestUrl: url)
        request.getRequest()
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.update(_:)) , name: "SmartOrderMenu", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Menu.sharedInstance.menuLength()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellID = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        //category
        let label = cell.viewWithTag(10) as! UILabel
       
        //imgload
        let imgView = cell.viewWithTag(100) as! UIImageView
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        imgView.image = UIImage(named: "cake")
        label.text = "Hello \(indexPath.row)"
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    
        let curCategory = Menu.sharedInstance.categoryAtIndex(indexPath.row)
        let CategoryVC = storyboard?.instantiateViewControllerWithIdentifier("Category") as? CategoryViewController
        CategoryVC!.menu = curCategory
        self.navigationController?.pushViewController(CategoryVC!, animated: true)
    }
    
        
    func loadMenu(fromDict: NSDictionary){
        Menu.sharedInstance.createMenu(fromDict)
        self.collectionView.reloadData()
    }
    
    func update(notification: NSNotification){
        let jsonData = notification.object as? NSDictionary
        let state = jsonData!["code"] as? Int
        if(state == 200){
            let menuJson = jsonData!["data"] as? NSDictionary
            loadMenu(menuJson!)
        }
        else{
            print("Error came up")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

