//
//  SheetProductsVC.swift
//  ContractGo
//
//  Created by Bhoomika on 19/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit
import MBProgressHUD
var worksheetID = Int()
var arrayPNNumber  = [String]()

class SheetProductsVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var objGetHelpVC : SelectPriceVC?
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblBottomPrice1: UILabel!
    @IBOutlet weak var lblBottomPrice2: UILabel!
    @IBOutlet weak var lblBottomPrice3: UILabel!
    @IBOutlet weak var lblBottomPrice4: UILabel!
    @IBOutlet weak var lblProductTitle: UILabel!
    
    //------Outlets-------
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var viewForPopUp: UIView!
    @IBOutlet weak var colView: UICollectionView!
    var parent_line_number  = 0
    let popupView = PopUp()
    
    var arrayDetails = [TblOptions]()
    var isEditMode = false
    var arrOfOptions : [[String:String]] = []
    var saveFileName = String()
    var saveDiscountValue = "1.0"
    var arrayOfProduct = [ProductDetails]()
    var templateView : viewForColumnSelection?
    var viewType : viewForViewTypeSelection?
    var sortView : viewForSort?
    var currentPrice = ""
    var productQuantity = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        tblView.backgroundColor = UIColor.black
        objGetHelpVC = self.storyboard!.instantiateViewController(withIdentifier: "SelectPriceVC") as? SelectPriceVC
        if let vc = self.objGetHelpVC{
            
            objGetHelpVC!.onEncounterSelection = { [weak self] index in
                self?.hideContentController(content: vc)
                self?.currentPrice = index;
                self?.tblView.reloadData()
            }
        }
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 200
        arrOfOptions = [["option":"SELECT PRICE LEVEL"],["option":"SET DISCOUNT"],["option":"SAVE"],["option":"LOAD"],["option":"COLUMN SELECT"],["option":"DISCOUNT MASTER"],["option":"CUSTOM LINE ITEM"],["option":"CATALOGS"]]
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        arrayDetails.removeAll()
        for obj in arrayPNNumber{
            let array = QueryEnum().productFetch(PN: obj)
            guard let _json = array.first else { return  }
            arrayOfProduct.append(ProductDetails(json: _json))
        }
        self.tblView.reloadData()
        lblProductTitle.text = createSheetFileName
        
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
    
    
    //MARK:- Back Action
    @IBAction func btnHidePopUpAction(_ sender: Any) {
        self.viewForPopUp.isHidden = true
        if let vc = self.objGetHelpVC{
            self.hideContentController(content: vc)
        }
    }
    
    @IBAction func btnAddProductAction(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "ListOfreatilersVC") as! ListOfreatilersVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnHomeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMenuAction(_ sender: Any) {
        self.viewForPopUp.isHidden = false
        self.view.bringSubviewToFront(viewForPopUp)
        
    }
    
    @IBAction func btnViewOption(_ sender: Any) {
        
        if let columnView = viewForViewTypeSelection.addTypeView(self.view) {
            print("added")
            viewType = columnView
            viewType?.delegate = self
        }
    }
    
    @IBAction func btnSortAction(_ sender: Any) {
        if let columnView = viewForSort.addSortView(self.view) {
            print("added")
            sortView = columnView
            sortView?.delegate = self
        }
    }
    @IBAction func btnTemplateAction(_ sender: Any) {
        if let  _templateView = viewForColumnSelection.addColumnView(self.view) {
            print("added")
            templateView = _templateView
            templateView?.delegate = self
        }
        
    }
    @IBAction func btnEditAction(_ sender: Any) {
        isEditMode = true
        let VC = storyboard?.instantiateViewController(withIdentifier: "EditProductVC") as! EditProductVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnQuantityAction(_ sender: Any) {
        productQuantity = productQuantity+1
        tblView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfProduct.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell : MainProductTVCell = tblView.dequeueReusableCell(withIdentifier: "MainProductTVCell") as? MainProductTVCell else {
            return UITableViewCell()
        }
        
        let arrOfData = arrayOfProduct[indexPath.row]
        var price = arrOfData.P1
        cell.btnQuantity.setTitle("\(productQuantity)", for: .normal)
        if currentPrice != ""{
            switch currentPrice {
            case "P1":
                price = arrOfData.P1
            case "P2":
                price = arrOfData.P2
            case "P3":
                price = arrOfData.P3
            case "P4":
                price = arrOfData.P4
            case "P5":
                price = arrOfData.P5
            default:
                price = arrOfData.P5
                
            }
        }
        if let value = Double(saveDiscountValue), let price = Double(price){
            let discount = value/100
            let discountVal = (price * discount)
            lblBottomPrice1.text = "$"+"\((price-discountVal))"
            lblBottomPrice2.text = "$"+"\((price-discountVal))"
            
            cell.lblTopPrice1.text = "$"+"\((price-discountVal))"
            cell.lblTopPrice2.text = "$"+"\((price-discountVal))"
            cell.lblTopPrice3.text = "$"+"\((price-discountVal))"
            cell.lblTopPrice4.text = "$"+"\((price-discountVal))"
        }
        cell.backgroundColor = UIColor.black
        cell.selectionStyle = .none
        cell.setUpData(data:arrOfData, number: indexPath.row+1)
        cell.btnEdit.addTarget(self, action: #selector(btnEditAction), for:.touchUpInside)
        cell.btnQuantity.addTarget(self, action: #selector(btnQuantityAction), for:.touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
extension SheetProductsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
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
            if let vc = self.objGetHelpVC{
                vc.view.frame = CGRect(x: colView.frame.origin.x+40, y: colView.frame.origin.y+20, width: colView.frame.size.width, height: colView.frame.size.height)
                self.displayContentController(content: vc)
                vc.tblView.reloadData()
            }
            
        case 1:
            addDiscountpopup()
        case 2:
            saveproduct()
        case 5:
            let VC = storyboard?.instantiateViewController(withIdentifier: "DiscountMasterVC") as! DiscountMasterVC
            navigationController?.pushViewController(VC, animated: true)
        default:
            print("default")
            
        }
    }
    func saveproduct(){
        print("save", worksheetID)
        let arrData = Database().getData(query: "SELECT WORKSHEET_ID FROM SAVE_DATA_MASTER_T where WORKSHEET_ID = '\(worksheetID)'") { (error: String) in
            print("Error: \(error)")
        }
        if arrData.count == 0 {
              DatabaseQuery().insertSAVE_DATA_MASTER_TToDB(worksheetName: createSheetFileName, ParentLN: "\(parent_line_number)", price_level: currentPrice, discountvalue: saveDiscountValue, sortBy: "", sortOrderType: "")
            insertProducts()
            
        }else{
            DatabaseQuery().updateSAVE_DATA_MASTER_TToDB(worksheetName: createSheetFileName, ParentLN: "\(parent_line_number)", price_level: currentPrice, discountvalue: saveDiscountValue, sortBy: "", sortOrderType: "")
            insertProducts()
        }
    }
    
    func insertProducts(){
        for obj in arrayOfProduct{
            DatabaseQuery().insertSAVE_PRODUCT_TToDB(product_id: obj.productID, pn: obj.PN, lineNumberId: obj.productID, quantity:productQuantity)
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
        saveproduct()
        self.popupView.removeFromSuperview()
        
    }
    
    @objc func saveDiscountAction(sender: UIButton) {
        print("discount",popupView.txtfield.text!)
        saveDiscountValue = popupView.txtfield.text!
        tblView.reloadData()
        self.popupView.removeFromSuperview()
    }
    
    @objc func removePopUpAction(sender: UIButton) {
        self.popupView.removeFromSuperview()
    }
}

extension SheetProductsVC: TemplateDelegate, ViewTypeDelegate, SortDelegate {
    
    func onSelection(_ close: Bool) {
        templateView?.removeFromSuperview()
        viewType?.removeFromSuperview()
        sortView?.removeFromSuperview()
    }
    
}
