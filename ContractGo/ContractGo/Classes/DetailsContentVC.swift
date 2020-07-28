//
//  DetailsContentVC.swift
//  ContractGo
//
//  Created by Bhoomika on 22/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class DetailsContentVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var arrDisplay : [[String:Any]]?
    @IBOutlet var tblView:UITableView!
    var isNestedlistEnded = false
    var navTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.backgroundColor = UIColor.black
        
        let cellnib : UINib = UINib(nibName: "tblSlideMenuCell", bundle: nil)
        tblView.register(cellnib, forCellReuseIdentifier: "tblSlideMenuCell")
        let cellnib1 : UINib = UINib(nibName: "tblProductListing", bundle: nil)
        tblView.register(cellnib1, forCellReuseIdentifier: "tblProductListing")
        addNavbar()
    }
    let navigationView = viewNavigation()
    
    func addNavbar(){
        navigationView.frame = CGRect(x: 0, y: 0 , width: FRAME_WIDTH, height: 64)
        navigationView.btnSliderMenu.isHidden = false
        navigationView.btnSliderMenu.addTarget(self, action: #selector(backAction(sender:)), for:.touchUpInside)
        navigationView.btnHome.addTarget(self, action: #selector(homeAction(sender:)), for:.touchUpInside)
        navigationView.lblSliderMenuTittle.text = navTitle
        navigationView.lblSliderMenuTittle.textAlignment = .left
        self.view.addSubview(navigationView)
    }
    @objc func backAction(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
     @objc func homeAction(sender: UIButton) {
           self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- Table Delegate Methode
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrDisplay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if isNestedlistEnded == true{
            let cell : tblProductListing = tableView.dequeueReusableCell(withIdentifier: "tblProductListing") as! tblProductListing
            cell.backgroundColor = UIColor.black
            cell.selectionStyle = .none
            if let value = arrDisplay?[indexPath.row]["PN"] as? String{
                cell.lblLeft?.text = value
            }
            if let value = arrDisplay?[indexPath.row]["PD"] as? String{
                cell.lblMiddle?.text = value
            }
            if let value = arrDisplay?[indexPath.row]["P1"] as? String{
                cell.lblRight?.text = "$" + value
            }
            return cell
            
        }else{
            let cell : tblSlideMenuCell = tableView.dequeueReusableCell(withIdentifier: "tblSlideMenuCell") as! tblSlideMenuCell
                   cell.backgroundColor = UIColor.black
                   cell.selectionStyle = .none
                   
                   cell.lblObject?.font = UIFont.init(name: "Georgia", size: 19.0)
            if let value = arrDisplay?[indexPath.row]["SL"] as? String{
                cell.lblObject?.text = value
            }
            return cell

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrDisplay?[indexPath.row]["lineNumber"] as? Int,arrDisplay?[indexPath.row]["SL"] ?? nil )
       
        
        if isNestedlistEnded == true{
            guard let PN = arrDisplay?[indexPath.row]["PN"] as? String else {return }
            guard let parentLineNumber = arrDisplay?[indexPath.row]["parentLineNumber"] as? Int else {return }
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "SheetProductsVC") as! SheetProductsVC
            arrayPNNumber.append(PN)
            VC.parent_line_number = parentLineNumber
            navigationController?.pushViewController(VC, animated: true)
            return
            
            //            guard let PN = arrDisplay?[indexPath.row]["PN"] as? String else {return }
            //            guard let parentLineNumber = arrDisplay?[indexPath.row]["parentLineNumber"] as? Int else {return }
            //
            //            let VC = storyboard?.instantiateViewController(withIdentifier: "MainProductVC") as! MainProductVC
            //            VC.PNNumber = PN
            //            VC.parent_line_number = parentLineNumber
            //            navigationController?.pushViewController(VC, animated: true)
            //            return
        }
        guard let int = arrDisplay?[indexPath.row]["lineNumber"] as? Int else {return }
        guard let _title = arrDisplay?[indexPath.row]["SL"] as? String else {return }
        
        let array = QueryEnum().repetitiveFetch(parentLineNumber: int)
        if array.isEmpty{
            let detailList = QueryEnum().listFetch(parentLineNumber: int)
            let VC = storyboard?.instantiateViewController(withIdentifier: "DetailsContentVC") as! DetailsContentVC
            VC.isNestedlistEnded = true
            VC.arrDisplay = detailList
            VC.navTitle = _title
            navigationController?.pushViewController(VC, animated: true)
        }else{
            let VC = storyboard?.instantiateViewController(withIdentifier: "DetailsContentVC") as! DetailsContentVC
            VC.arrDisplay = array
            VC.navTitle = _title

            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
}
