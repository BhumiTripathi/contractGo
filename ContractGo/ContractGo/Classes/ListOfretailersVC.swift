//
//  ListOfretailersVC.swift
//  ContractGo
//
//  Created by Bhoomika on 21/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import Foundation
import UIKit

class ListOfreatilersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let arr = ["Knoll", "Haworth", "Cherryman", "Humanscale"]
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
        navigationView.lblSliderMenuTittle.text = ""
        navigationView.btnSliderMenu.addTarget(self, action: #selector(backAction(sender:)), for:.touchUpInside)
        navigationView.lblSliderMenuTittle.textAlignment = .left
        self.view.addSubview(navigationView)
    }
    @objc func backAction(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Table Delegate Methode
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : tblSlideMenuCell = tableView.dequeueReusableCell(withIdentifier: "tblSlideMenuCell") as! tblSlideMenuCell
        cell.backgroundColor = UIColor.black
        cell.selectionStyle = .none
        
        cell.lblObject?.font = UIFont.init(name: "Georgia", size: 19.0)
        cell.lblObject?.text = arr[indexPath.row]
        
        //let strImageName = mutArrMenu[indexPath.row]["imagename"] as! String
        //cell.lblImg.text = mutArrFAIcons[indexPath.row]["Icon"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arr[indexPath.row] == "Knoll"{
            let array = QueryEnum().FirstLevelFetch()
            
            let arrValue = array.compactMap {$0["SL"] as? String }
            
            print(arrValue)
            let string = arrValue.joined(separator: ", ")
            //            let str = arr.
            let VC = storyboard?.instantiateViewController(withIdentifier: "ContentDisplayVC") as! ContentDisplayVC
            VC.arrDisplay = [string]
            navigationController?.pushViewController(VC, animated: true)
            
        }
    }
    
}



