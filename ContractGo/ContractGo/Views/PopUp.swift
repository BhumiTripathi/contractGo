//
//  PopUp.swift
//  ContractGo
//
//  Created by Bhoomika on 05/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class PopUp: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var txtfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

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
           let nib = UINib(nibName: "PopUp", bundle: bundle)
           let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
           view.frame = bounds
           view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           
           self.addSubview(view)
           
       }

}
