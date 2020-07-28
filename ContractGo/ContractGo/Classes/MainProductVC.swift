//
//  ViewController.swift
//  DemoProject
//
//  Created by Bhumika tripathi on 21/06/20.
//  Copyright © 2020 Bhumika tripathi. All rights reserved.
//

import UIKit
import MBProgressHUD
var productDictionary = ProductDetails()
var currentSelectedPrice = productDictionary.P1
var fileID = Int()
var selectedproductOptions = [storedProductOption]()

class MainProductVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    var objGetHelpVC : SelectPriceVC?
    
    @IBOutlet weak var bottomPList: UILabel!
    @IBOutlet weak var bottomExList: UILabel!
    @IBOutlet weak var lblTopExList: UILabel!
    @IBOutlet weak var lblTopPlist: UILabel!
    @IBOutlet weak var lblProductTitle: UILabel!
    @IBOutlet weak var lblSubProductTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    //------Outlets-------
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewForPopUp: UIView!
    @IBOutlet weak var colView: UICollectionView!
    var PNNumber  = ""
    var parent_line_number  = 0

    //------Variables and constant-------
    var arrayDetails = [TblOptions]()
    var isEditMode = false
    var arrOfProducts : [[String:Any]] = []
    var arrOfOptions : [[String:String]] = []
    var saveFileName = String()
    var saveDiscountValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let array = QueryEnum().productFetch(PN: PNNumber)
        guard let _json = array.first else { return  }
        productDictionary = ProductDetails(json: _json)
        objGetHelpVC = self.storyboard!.instantiateViewController(withIdentifier: "SelectPriceVC") as? SelectPriceVC
        if let vc = self.objGetHelpVC{
            
            objGetHelpVC!.onEncounterSelection = { [weak self] index in
                self?.hideContentController(content: vc)
                self?.updatePrice()
            }
        }
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 200
        arrOfOptions = [["option":"SELECT PRICE LEVEL"],["option":"SET DISCOUNT"],["option":"SAVE"],["option":"LOAD"],["option":"COLUMN SELECT"],["option":"DISCOUNT MASTER"],["option":"ADD TO WORK SHEET"]]
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        arrOfProducts.removeAll()
        arrayDetails.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)

        self.setUpData()
        
        MBProgressHUD.hide(for: self.view, animated: true)
        setCollectionLayout()
        
    }
    
    //MARK:- Setup array
    func setCollectionLayout() {
        var intSize = colView.frame.width / 2
        intSize -= 4
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        layout.itemSize = CGSize(width: intSize, height: 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        colView.collectionViewLayout = layout
    }
    
    func updatePrice(){
        print("currentSelectedPrice",currentSelectedPrice)
        lblTopPlist.text = currentSelectedPrice
        bottomPList.text = "$"+currentSelectedPrice
        lblTopExList.text = currentSelectedPrice
        bottomExList.text = "$"+currentSelectedPrice
        updatePriceValue()

    }
    func setUpData(){
        
        updatePrice()
        
        lblProductTitle.text = productDictionary.PN
        lblSubProductTitle.text = productDictionary.PN
        productDescription.text = productDictionary.PD
        
        let arr = [productDictionary.G0, productDictionary.G1, productDictionary.G2, productDictionary.G3]
        for obj in arr{
            arrOfProducts = QueryEnum().fetchTableOptions(PO: obj)
            arrayDetails.append(TblOptions(json: arrOfProducts.first ?? [:]))
        }
        tblView.reloadData()
    }
    
    //MARK:- Back Action
    @IBAction func btnHomeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        self.viewForPopUp.isHidden = false
        
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        isEditMode = true
        let VC = storyboard?.instantiateViewController(withIdentifier: "EditProductVC") as! EditProductVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnHidePopUpAction(_ sender: Any) {
        self.viewForPopUp.isHidden = true
        if let vc = self.objGetHelpVC{
            self.hideContentController(content: vc)
        }
    }
    
    
    func displayContentController(content: UIViewController) {
        
        self.addChild(content)
        self.view.addSubview(content.view)
        content.didMove(toParent: self)
        
    }
    
    func hideContentController(content: UIViewController) {
        content.willMove(toParent: nil)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayDetails.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : tblDataCell = tblView.dequeueReusableCell(withIdentifier: "tblDataCell") as? tblDataCell else {
            return UITableViewCell()
        }
        let arrOfData = arrayDetails[indexPath.row]
        
        cell.lblLabel1.text = arrOfData.OG
        let containsEntry = selectedproductOptions.contains{ $0.PO == arrOfData.PO }
        if containsEntry {
            let index = selectedproductOptions.filter({$0.PO == arrOfData.PO}).first
            cell.lblLabel2.text = index?.OD
            cell.lblLabel4.text = arrOfData.O1

        } else {
            cell.lblLabel2.text = ""
            cell.lblLabel4.text = ""
            cell.lblLabel3.text = ""
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "EditProductVC") as! EditProductVC
        
        navigationController?.pushViewController(VC, animated: true)
    }
    let popupView = PopUp()
    
}

extension MainProductVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrOfOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell : colSelectionCell = colView.dequeueReusableCell(withReuseIdentifier: "colSelectionCell", for: indexPath) as? colSelectionCell else {
            return UICollectionViewCell()
        }
        
        cell.lblOptionName.text = arrOfOptions[indexPath.row]["option"]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("set price level", currentSelectedPrice)
            if let vc = self.objGetHelpVC{
                vc.view.frame = CGRect(x: colView.frame.origin.x+40, y: colView.frame.origin.y+20, width: colView.frame.size.width, height: colView.frame.size.height)
                self.displayContentController(content: vc)
                vc.tblView.reloadData()
            }
            
        case 1:
            addDiscountpopup()
        case 2:
            print("save")
            addSavepopup()
        case 5:
            let VC = storyboard?.instantiateViewController(withIdentifier: "DiscountMasterVC") as! DiscountMasterVC
            navigationController?.pushViewController(VC, animated: true)
        default:
            print("default")
            
        }
    }
    
    
    func addSavepopup(){
        popupView.frame = CGRect(x: colView.frame.origin.x+40, y: colView.frame.origin.y+20, width: colView.frame.size.width, height: colView.frame.size.height)
        popupView.titleLabel.text = "Save As"
        popupView.txtfield.placeholder = "Enter the File Name"
        popupView.saveButton.setTitle("Save", for: .normal)
        popupView.txtfield.keyboardType = .alphabet

        popupView.saveButton.addTarget(self, action: #selector(saveFileAction(sender:)), for:.touchUpInside)
        popupView.closeButton.addTarget(self, action: #selector(removePopUpAction(sender:)), for:.touchUpInside)
        
        self.view.addSubview(popupView)
    }
    
    func addDiscountpopup(){
        popupView.frame = CGRect(x: colView.frame.origin.x+40, y: colView.frame.origin.y+20, width: colView.frame.size.width, height: colView.frame.size.height)
        popupView.titleLabel.text = "Set Discount"
        popupView.txtfield.placeholder = "Discount"
        popupView.txtfield.keyboardType = .numberPad
        popupView.saveButton.setTitle("Save", for: .normal)
        
        popupView.saveButton.addTarget(self, action: #selector(saveDiscountAction(sender:)), for:.touchUpInside)
        popupView.closeButton.addTarget(self, action: #selector(removePopUpAction(sender:)), for:.touchUpInside)
        
        self.view.addSubview(popupView)
    }
    @objc func saveFileAction(sender: UIButton) {
        print("save",popupView.txtfield.text!)
        saveFileName = popupView.txtfield.text!
        DatabaseQuery().insertSAVE_DATA_MASTERToDB(fileName:popupView.txtfield.text!,ParentLN: "\(parent_line_number)", price_level: currentSelectedPrice, discountvalue:saveDiscountValue)
        self.popupView.removeFromSuperview()

    }
    
    @objc func saveDiscountAction(sender: UIButton) {
        print("discount",popupView.txtfield.text!)
        saveDiscountValue = popupView.txtfield.text!
        updatePriceValue()
        self.popupView.removeFromSuperview()

    }
    
    func updatePriceValue(){
        if let value = Double(saveDiscountValue), let price = Double(currentSelectedPrice){
            let discount = value/100
            let discountVal = (price * discount)
            lblTopExList.text = "\(price-discountVal)"
            bottomExList.text = "$"+"\((price-discountVal))"
        }
    }
    
    @objc func removePopUpAction(sender: UIButton) {
        self.popupView.removeFromSuperview()
    }
}

