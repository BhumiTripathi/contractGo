//
//  viewForViewTypeSelection.swift
//  DemoProject
//
//  Created by Bhumika tripathi on 15/07/20.
//  Copyright © 2020 Bhumika tripathi. All rights reserved.
//

import UIKit
protocol ViewTypeDelegate: class {
    func onSelection(_ close: Bool)
}
class viewForViewTypeSelection: UIView {
    weak var delegate: ViewTypeDelegate?

    //------Outlets------
    @IBOutlet weak var btnCondenseLine: UIButton!
    @IBOutlet weak var btnCondenseWithDescription: UIButton!
    @IBOutlet weak var btnExtended: UIButton!
    
    //MARK:- Outlets Action
    
    @IBAction func btnCondenseLineSelection(_ sender: Any) {
        delegate?.onSelection(true)
    }
    
    @IBAction func btnCondenseWithDescriptionSelection(_ sender: Any) {
        delegate?.onSelection(true)

    }
    
    @IBAction func btnExtendedSelection(_ sender: Any) {
        delegate?.onSelection(true)

    }
    
}

extension viewForViewTypeSelection {
    
    public class func addTypeView(_ superView: UIView) -> viewForViewTypeSelection? {
        
        var typeSelectView: viewForViewTypeSelection?
        if typeSelectView == nil {
            typeSelectView = UINib(nibName: "viewForViewTypeSelection", bundle: nil).instantiate(withOwner: self, options: nil).last as? viewForViewTypeSelection
            guard let atypeSelectView = typeSelectView else { return nil }
            typeSelectView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(atypeSelectView)
            //acolumnView.initialize()
            return typeSelectView
        }
        return nil
    }
    
}
