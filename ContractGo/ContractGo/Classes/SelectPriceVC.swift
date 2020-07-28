//
//  SelectPriceVC.swift
//  ContractGo
//
//  Created by Bhoomika on 04/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class SelectPriceVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let arr = [productDictionary.P1, productDictionary.P2, productDictionary.P3, productDictionary.P4,productDictionary.P5, productDictionary.P6]
    @IBOutlet weak var tblView: UITableView!
    var onEncounterSelection:(String)->() = {_ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : tblcellSelectprice = tableView.dequeueReusableCell(withIdentifier: "tblcellSelectprice") as! tblcellSelectprice
        cell.lbl1.text = "P" + "\(indexPath.row+1)"
        cell.imgView.image = UIImage(named: "RadioButton_NotSelected")
        let val = arr[indexPath.row]
        if currentSelectedPrice == val{
            cell.imgView.image = UIImage(named: "RadioButton_Selected")
        }

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            currentSelectedPrice = productDictionary.P1
            case 1:
            currentSelectedPrice = productDictionary.P2
            case 2:
            currentSelectedPrice = productDictionary.P3
            case 3:
            currentSelectedPrice = productDictionary.P4
            case 4:
            currentSelectedPrice = productDictionary.P5
            case 5:
            currentSelectedPrice = productDictionary.P6
        default:
            currentSelectedPrice = productDictionary.P1

        }
        self.onEncounterSelection("P" + "\(indexPath.row+1)")
    }
    
}
