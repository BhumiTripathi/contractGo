//
//  ContentDisplayVC.swift
//  ContractGo
//
//  Created by Bhoomika on 22/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class ContentDisplayVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var arrDisplay : [String]?
    @IBOutlet var tblView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.backgroundColor = UIColor.black
        
        let cellnib : UINib = UINib(nibName: "tblSlideMenuCell", bundle: nil)
        tblView.register(cellnib, forCellReuseIdentifier: "tblSlideMenuCell")
        
        addNavbar()
    }
    let navigationView = viewNavigation()
    
    func addNavbar(){
        navigationView.frame = CGRect(x: 0, y: 0 , width: FRAME_WIDTH, height: 64)
        navigationView.btnSliderMenu.isHidden = false
        navigationView.btnSliderMenu.addTarget(self, action: #selector(backAction(sender:)), for:.touchUpInside)
        navigationView.btnHome.addTarget(self, action: #selector(homeAction(sender:)), for:.touchUpInside)

        navigationView.lblSliderMenuTittle.text = "ContractGo"
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
        
        let cell : tblSlideMenuCell = tableView.dequeueReusableCell(withIdentifier: "tblSlideMenuCell") as! tblSlideMenuCell
        cell.backgroundColor = UIColor.black
        cell.selectionStyle = .none
        
        cell.lblObject?.font = UIFont.init(name: "Georgia", size: 19.0)
        if let value = arrDisplay?[indexPath.row] {
            cell.lblObject?.text = value
        }
        //let strImageName = mutArrMenu[indexPath.row]["imagename"] as! String
        //cell.lblImg.text = mutArrFAIcons[indexPath.row]["Icon"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrDisplay?[indexPath.row].contains("KNOLL") ?? false{
            let array = QueryEnum().SecondLevelfetch()
            let VC = storyboard?.instantiateViewController(withIdentifier: "DetailsContentVC") as! DetailsContentVC
            VC.arrDisplay = array
            VC.navTitle = "ContractGo"
            navigationController?.pushViewController(VC, animated: true)
        }
        //        else{
        //            //let int =
        //            let array = QueryEnum().repetitiveFetch(parentLineNumber: 3)
        //            let VC = storyboard?.instantiateViewController(withIdentifier: "DetailsContentVC") as! DetailsContentVC
        //            VC.arrDisplay = array
        //            navigationController?.pushViewController(VC, animated: true)
        //        }
    }
    
}
