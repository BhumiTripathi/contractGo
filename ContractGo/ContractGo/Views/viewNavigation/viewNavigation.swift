//
//  viewNavigation.swift
//  AllConverter
//
//  Created by Bhumika tripathi on 10/15/17.
//  Copyright © 2017 Bhumika tripathi. All rights reserved.
//

import UIKit


class viewNavigation: UIView, UISearchBarDelegate {
    @IBOutlet var btnSliderMenu:UIButton!
    @IBOutlet var lblSliderMenuTittle: UILabel!
    
    @IBOutlet weak var btnHome: UIButton!
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
        let nib = UINib(nibName: "viewNavigation", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
}

