//
//  viewForSort.swift
//  DemoProject
//
//  Created by Bhumika tripathi on 14/07/20.
//  Copyright © 2020 Bhumika tripathi. All rights reserved.
//

import UIKit
protocol SortDelegate: class {
    func onSelection(_ close: Bool)
}
class viewForSort: UIView {
    weak var delegate: SortDelegate?

    //----Outlets------
    
    @IBOutlet weak var txtSortBy: UITextField!
    @IBOutlet weak var txtFirstOrderBy: UITextField!
    @IBOutlet weak var txtThenBy: UITextField!
    @IBOutlet weak var txtSecondOrderBy: UITextField!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var leadingConstraintOfTblView: NSLayoutConstraint!
    @IBOutlet weak var topConstraintOfTblView: NSLayoutConstraint!
    
    //-----Variables and constant------
    private let cellID = "tblSortCell"
    var intSelectedSort : Int = 0
    var arrOfSortOptions : [String] = []
    
    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: cellID)
      
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.isHidden = true
        arrOfSortOptions = ["Part Number","Description","Qty","List"]
        self.tblView.reloadData()
        self.setUpView()
    }

    //MARK:- set up view
    func setUpView(){
        
        self.tblView.addBorders()
        self.txtSortBy.addBorders(color: .black)
        self.txtThenBy.addBorders(color: .black)
        self.txtFirstOrderBy.addBorders(color: .black)
        self.txtSecondOrderBy.addBorders(color: .black)
        self.txtSortBy.isEnabled = false
//        self.txtFirstOrderBy.isEditing = false
//        self.txtSecondOrderBy.isEditing = false
//        self.txtThenBy.isEditing = false
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    //MARK:- Switch between the sort type
    func switchSortType(){
        
        self.tblView.isHidden = false
        
        switch intSelectedSort {
        case 1:
            
            leadingConstraintOfTblView.constant = txtSortBy.frame.origin.x
            topConstraintOfTblView.constant = txtSortBy.frame.origin.y + 30
            break
        case 2:
            leadingConstraintOfTblView.constant = txtThenBy.frame.origin.x
            topConstraintOfTblView.constant = txtThenBy.frame.origin.y + 30
            break
        case 3:
            leadingConstraintOfTblView.constant = txtFirstOrderBy.frame.origin.x
            topConstraintOfTblView.constant = txtFirstOrderBy.frame.origin.y + 30
            break
        case 4:
            leadingConstraintOfTblView.constant = txtSecondOrderBy.frame.origin.x
            topConstraintOfTblView.constant = txtSecondOrderBy.frame.origin.y + 30
            break
        default:
            break
        }
    }
    
    //MARK:- Sort By action
    @IBAction func didBeginEdit(_ sender : UIButton){
        
        self.intSelectedSort = 1
        self.switchSortType()
    }
    
    //MARK:-
    @IBAction func txtThenByEditAction(_ sender : UIButton){
        self.intSelectedSort = 2
        self.switchSortType()
    }
    
    //MARK:-
    @IBAction func txtFirstOrderByEditAction(_ sender: UIButton){
        self.intSelectedSort = 3
        self.switchSortType()
    }
    
    //MARK:-
    @IBAction func txtSecondOrderByEditAction(_ sender:UIButton){
        self.intSelectedSort = 4
        self.switchSortType()
    }
    @IBAction func btnApplyAction(_ sender: Any) {
        delegate?.onSelection(true)
    }
}

extension viewForSort : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrOfSortOptions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! tblSortCell
        cell.lblSortFilter.text = arrOfSortOptions[indexPath.row]
        return cell
        
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelection(true)

        self.tblView.isHidden = true
    }
}

//MARK:- Add calendar to the view
extension viewForSort {
    
    public class func addSortView(_ superView: UIView) -> viewForSort? {
        
        var sortView: viewForSort?
        if sortView == nil {
            sortView = UINib(nibName: "viewForSort", bundle: nil).instantiate(withOwner: self, options: nil).last as? viewForSort
            guard let asortView = sortView else { return nil }
            sortView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(asortView)
            asortView.initialize()
            return sortView
        }
        return nil
    }
    
}

class UITextFieldBoundary : UITextField{
    
    func addBorderOnEdges(){
        
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}

extension UIView {
    
    func addBorders(color:UIColor = UIColor.secondarySystemBackground){
        
        self.layer.cornerRadius = 2.0
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
    }
}
