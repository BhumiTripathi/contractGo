//
//  CreateSheetVC.swift
//  ContractGo
//
//  Created by Bhoomika on 18/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit
var createSheetFileName = ""
class CreateSheetVC: UIViewController {
    
    @IBOutlet weak var fileNametxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addNavbar()
        
        createSheetFileName = ""
        worksheetID = 0
   
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
    
    @IBAction func saveACtion(_ sender: Any) {
        if fileNametxt.text! == ""{return}
        createSheetFileName = fileNametxt.text!
        arrayPNNumber.removeAll()
        let VC = storyboard?.instantiateViewController(withIdentifier: "ListOfreatilersVC") as! ListOfreatilersVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
}
