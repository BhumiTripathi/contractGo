//
//  ValidateTableVC.swift
//  ContractGo
//
//  Created by Bhoomika on 07/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class ValidateTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tblView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellnib1 : UINib = UINib(nibName: "tblProductListing", bundle: nil)
        tblView.register(cellnib1, forCellReuseIdentifier: "tblProductListing")
        addNavbar()
        // Do any additional setup after loading the view.
    }
    
    let navigationView = viewNavigation()
    
    func addNavbar(){
        navigationView.frame = CGRect(x: 0, y: 0 , width: FRAME_WIDTH, height: 64)
        navigationView.btnSliderMenu.isHidden = false
        navigationView.btnSliderMenu.addTarget(self, action: #selector(backAction(sender:)), for:.touchUpInside)
        navigationView.btnHome.addTarget(self, action: #selector(homeAction(sender:)), for:.touchUpInside)
        navigationView.lblSliderMenuTittle.text = "Validate Table"
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
        return 50;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell : tblProductListing = tableView.dequeueReusableCell(withIdentifier: "tblProductListing") as! tblProductListing
            
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
