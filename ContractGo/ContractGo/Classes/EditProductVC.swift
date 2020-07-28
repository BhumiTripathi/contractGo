//
//  EditProductVC.swift
//  ContractGo
//
//  Created by Bhoomika on 25/06/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit
import MBProgressHUD
class EditProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblSubProductTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    //------Outlets-------
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var PNNumber  = ""
    //------Variables and constant-------
    var arrayDetails = [TblOptions]()
    var arrayMain = [TblOptions]()
    var isEditMode = false
    var arrOfProducts : [[String:Any]] = []
    var index = 0
    let arr = [productDictionary.G0, productDictionary.G1, productDictionary.G2, productDictionary.G3]

    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 200
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.setUpData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //MARK:- Setup array
    func setUpData(){
        lblSubProductTitle.text = productDictionary.PN
        productDescription.text = productDictionary.PD
        
        for obj in arr{
            arrOfProducts = QueryEnum().fetchTableOptions(PO: obj)
            for (index,obj) in arrOfProducts.enumerated() {
                if index == 0{
                    arrayMain.append(TblOptions(json: obj))
                }
            }
        }
        getProductdetail()
        tblView.reloadData()
    }
    
    func getProductdetail(){
        arrayDetails.removeAll()
        let obj = arr[index]
        arrOfProducts = QueryEnum().fetchTableOptions(PO: obj)
        for object in arrOfProducts {
            arrayDetails.append(TblOptions(json: object))
        }
    }
    
    //MARK:- Back Action
    @IBAction func btnHomeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPreviousAction(_ sender: Any) {
        index = index-1
        getProductdetail()
        tblView.reloadData()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        print(index, arr.count)
        index = index+1
        if index > arr.count-1 {
            self.navigationController?.popViewController(animated: true)
           return
        }
        getProductdetail()
        tblView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayMain.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView() // The width will be the same as the cell, and the height should be set in tableView:heightForRowAtIndexPath:
        view.backgroundColor = UIColor.black
        let label = UILabel()
        label.textColor = UIColor.white
        let button   = UIButton(type: UIButton.ButtonType.system)
        
        button.addTarget(self, action: #selector(headerAction(sender:)), for:.touchUpInside)
        label.frame = CGRect(x: 50, y: 0, width: 300, height: 40)
        button.frame = CGRect(x: 50, y: 0, width: 300, height: 40)

        let arrOfData = arrayMain[section]
        if index == section{
            label.text = "- " + arrOfData.OG

        }else{
        label.text = "+ " + arrOfData.OG
        }
        
        view.addSubview(label)
        view.addSubview(button)
        view.bringSubviewToFront(label)
        return view
    }
    @objc func headerAction(sender : UIButton){
        
       }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if index == section{
            return arrayDetails.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : tblDataCell = tblView.dequeueReusableCell(withIdentifier: "tblDataCell") as? tblDataCell else {
            return UITableViewCell()
        }
        let arrOfData = arrayDetails[indexPath.row]
        
        cell.lblLabel1.text = arrOfData.OD
        
        cell.lblLabel3.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let arrOfData = arrayDetails[indexPath.row]
         let containsEntry = selectedproductOptions.contains{ $0.PO == arrOfData.PO }
                if containsEntry {
                    let index = selectedproductOptions.firstIndex(where: {$0.PO == arrOfData.PO})
                    selectedproductOptions.remove(at: index ?? 0)
                    selectedproductOptions.append(storedProductOption(optID: arrOfData.optID, Od: arrOfData.OD, Po: arrOfData.PO))

                    print("index", index!)
    
                } else {
                    selectedproductOptions.append(storedProductOption(optID: arrOfData.optID, Od: arrOfData.OD, Po: arrOfData.PO))
                    // Insert maybe?
                }
        
    }
    
}

class storedProductOption {
    var opt_id : Int = 0
    var OD : String = ""
    var PO : String = ""

    public init(optID: Int, Od :String, Po:String){
       opt_id = optID
       OD = Od
       PO = Po
    }
}
