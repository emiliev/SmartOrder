//
//  OrderCustomCell.swift
//  Smart Order
//
//  Created by Emil Iliev on 7/2/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class OrderCustomCell: UITableViewCell {

    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var quantity: QuantityCustomView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
