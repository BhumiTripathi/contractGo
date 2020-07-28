//
//  DiscountMasterVC.swift
//  ContractGo
//
//  Created by Bhoomika on 06/07/20.
//  Copyright © 2020 Bhoomika. All rights reserved.
//

import UIKit

class DiscountMasterVC: UIViewController {
    @IBOutlet weak var sellTxtField: UITextField!
    @IBOutlet weak var marginTxtField: UITextField!
    @IBOutlet weak var markupTxtField: UITextField!
    @IBOutlet weak var purchaseTxtField: UITextField!
    @IBOutlet weak var viewCatalogCode: UIView!
    @IBOutlet weak var topTextFieldStackView: UIStackView!
    @IBOutlet weak var viewIgnoreAsterisk: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    
    @IBOutlet weak var btnGlobal: UIButton!
    @IBOutlet weak var btnCatalog: UIButton!

    @IBOutlet weak var btnIgnoreAsterisk: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavbar()
        
        // Do any additional setup after loading the view.
    }
    let navigationView = viewNavigation()
    
    func addNavbar(){
        navigationView.frame = CGRect(x: 0, y: 0 , width: FRAME_WIDTH, height: 64)
        navigationView.btnSliderMenu.isHidden = false
        navigationView.btnSliderMenu.addTarget(self, action: #selector(backAction(sender:)), for:.touchUpInside)
        navigationView.btnHome.addTarget(self, action: #selector(homeAction(sender:)), for:.touchUpInside)

        navigationView.lblSliderMenuTittle.text = "Discount Master"
        navigationView.lblSliderMenuTittle.textAlignment = .left
        self.view.addSubview(navigationView)
    }
    @objc func backAction(sender : UIButton){
        self.navigationController?.popViewController(animated: true)
    }
     @objc func homeAction(sender: UIButton) {
           self.navigationController?.popToRootViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnIgnoreAsteriskAction(_ sender: Any) {
    }
    @IBAction func btnGlobalAction(_ sender: Any) {
        viewIgnoreAsterisk.isHidden = true
        viewCatalogCode.isHidden = true
        topStackView.isHidden = false
        topTextFieldStackView.isHidden = false
    }
    @IBAction func btnCatalogAction(_ sender: Any) {
        topStackView.isHidden = true
        topTextFieldStackView.isHidden = true
        viewIgnoreAsterisk.isHidden = false
        viewCatalogCode.isHidden = false
      }
    @IBAction func loadAction(_ sender: Any) {
    }
    @IBAction func saveAction(_ sender: Any) {
    }
    @IBAction func refreshAction(_ sender: Any) {
    }
    @IBAction func applyAction(_ sender: Any) {
    }
    
    @IBAction func addDiscountAction(_ sender: Any) {
    }
    @IBAction func validateAction(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "ValidateTableVC") as! ValidateTableVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func buildTableAction(_ sender: Any) {
    }
  
}
