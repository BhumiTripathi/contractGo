//
//  MainProductTVCell.swift
//  ContractGo
//
//  Created by Bhoomika on 19/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class MainProductTVCell: UITableViewCell {
    @IBOutlet weak var lblSubProductTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    var arrOfProducts : [[String:Any]] = []
    var arrOfOptions : [[String:String]] = []
    var arrayDetails = [TblOptions]()
    @IBOutlet weak var lblSerialNumber: UILabel!
    @IBOutlet weak var lbldata1: UILabel!
    @IBOutlet weak var lbldata2: UILabel!
    @IBOutlet weak var lbldata3: UILabel!
    @IBOutlet weak var lbldata4: UILabel!
    @IBOutlet weak var lbldata5: UILabel!
    @IBOutlet weak var lblTopPrice1: UILabel!
    @IBOutlet weak var lblTopPrice2: UILabel!
    @IBOutlet weak var lblTopPrice3: UILabel!
    @IBOutlet weak var lblTopPrice4: UILabel!
    
    @IBOutlet weak var btnQuantity: UIButton!
    @IBOutlet weak var btnEdit: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.black
        
    }
    func setUpData(data : ProductDetails, number : Int){
        
        lblSerialNumber.text = "\(number)"
        lblSubProductTitle.text = data.PN
        productDescription.text = data.PD
       
        let arr = [data.G0, data.G1, data.G2, data.G3]
        arrOfProducts.removeAll()
        arrayDetails.removeAll()
        for obj in arr{
        arrOfProducts = QueryEnum().fetchTableOptions(PO: obj)
        arrayDetails.append(TblOptions(json: arrOfProducts.first ?? [:]))
        }
        for (index,obj) in arrayDetails.enumerated(){
            switch index {
            case 0:
                lbldata1.text = obj.OG
                case 1:
                lbldata2.text = obj.OG
                case 2:
                lbldata3.text = obj.OG
                case 3:
                lbldata4.text = obj.OG
                case 4:
                lbldata5.text = obj.OG
                
            default:
                lbldata1.text = obj.OG
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
