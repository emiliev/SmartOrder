//
//  QuantityCustomView.swift
//  Smart Order
//
//  Created by Emil Iliev on 7/2/16.
//  Copyright © 2016 Emil Iliev. All rights reserved.
//

import UIKit

class QuantityCustomView: UIView {

    @IBOutlet weak var digit: UILabel!
    @IBOutlet weak var view: UIView!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    func setup(){
        NSBundle.mainBundle().loadNibNamed("QuantityCustomView", owner: self, options: nil)
        self.addSubview(view)
    }
    
}
