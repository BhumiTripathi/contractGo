//
//  AddDiscountPopUp.swift
//  ContractGo
//
//  Created by Bhoomika on 07/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class AddDiscountPopUp: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUpNib()
        // setFontAndColor()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        setUpNib()
        
    }
    
    
    func setUpNib() {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "AddDiscountPopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
}
