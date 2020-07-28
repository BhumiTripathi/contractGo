//
//  viewForColumnSelection.swift
//  DemoProject
//
//  Created by Bhumika tripathi on 15/07/20.
//  Copyright © 2020 Bhumika tripathi. All rights reserved.
//

import UIKit
protocol TemplateDelegate: class {
    func onSelection(_ close: Bool)
}
class viewForColumnSelection: UIView {
    weak var delegate: TemplateDelegate?

    // square
    //MARK:- IBOultet actions
//    var onSelection:(Bool, Int)->() = {_, _ in }

    @IBAction func btnPartNumberSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnDescriptionSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnQtySelection(_ sender: Any) {
     
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnListSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnBuySelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnSellSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnMarginSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnExtendedColumnSelection(_ sender: Any) {
        
        let button = sender as? UIButton
        button?.isSelected = !(button?.isSelected ?? false)
        if button?.isSelected ?? false{
            button?.setImage(UIImage.init(systemName: "checkmark.rectangle.fill"), for: .normal)
        }else{
            button?.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func btnCloseViewAction(_ sender: Any) {
        delegate?.onSelection(true)
    }
    
    @IBAction func btnLoadSelection(_ sender: Any) {
        
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
    }
}

extension viewForColumnSelection {
    
    public class func addColumnView(_ superView: UIView) -> viewForColumnSelection? {
        
        var columnView: viewForColumnSelection?
        if columnView == nil {
            columnView = UINib(nibName: "viewForColumnSelection", bundle: nil).instantiate(withOwner: self, options: nil).last as? viewForColumnSelection
            guard let acolumnView = columnView else { return nil }
            columnView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(acolumnView)
            //acolumnView.initialize()
            return columnView
        }
        return nil
    }
    
}
