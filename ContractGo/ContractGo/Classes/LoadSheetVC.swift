//
//  ValidateTableVC.swift
//  ContractGo
//
//  Created by Bhoomika on 07/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class LoadSheetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tblView:UITableView!
    var arraySheets = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellnib1 : UINib = UINib(nibName: "tblSlideMenuCell", bundle: nil)
        tblView.register(cellnib1, forCellReuseIdentifier: "tblSlideMenuCell")
        addNavbar()
        tblView.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        arraySheets =  QueryEnum().fetchWorksheet()
        tblView.reloadData()
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
        
        return arraySheets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : tblSlideMenuCell = tableView.dequeueReusableCell(withIdentifier: "tblSlideMenuCell") as! tblSlideMenuCell
        cell.backgroundColor = UIColor.black
        cell.lblObject.text = arraySheets[indexPath.row]["WORKSHEET_NAME"] as? String ?? ""
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createSheetFileName = arraySheets[indexPath.row]["WORKSHEET_NAME"] as? String ?? "test"
        let worksheetId = arraySheets[indexPath.row]["WORKSHEET_ID"] as? Int ?? 0
        let products = QueryEnum().fetchWorksheetProduct(worksheetId: worksheetId)
        guard let parentLineNumber = arraySheets[indexPath.row]["PARENT_LINE_NUMBER"] as? String else {return }
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "SheetProductsVC") as! SheetProductsVC
        var arrrOfproduct = [String]()
        products.map{arrrOfproduct.append($0["PN"] as? String ?? "")}
        print(arrrOfproduct)
        arrayPNNumber=arrrOfproduct
        VC.parent_line_number = Int(parentLineNumber) ?? 0
        navigationController?.pushViewController(VC, animated: true)
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

