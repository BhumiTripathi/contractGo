//
//  tblDataCell.swift
//  DemoProject
//
//  Created by Bhumika tripathi on 21/06/20.
//  Copyright © 2020 Bhumika tripathi. All rights reserved.
//

import UIKit

class tblDataCell: UITableViewCell {

    //------Outlets--------
    @IBOutlet weak var lblLabel4: UILabel!
    @IBOutlet weak var lblLabel3: UILabel!
    @IBOutlet weak var lblLabel2: UILabel!
    @IBOutlet weak var lblLabel1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
