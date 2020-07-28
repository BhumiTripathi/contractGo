//
//  tblSlideMenuCell.swift
//  AllConverter
//
//  Created by Bhumika tripathi on 10/15/17.
//  Copyright © 2017 Bhumika tripathi. All rights reserved.
//

import UIKit

class tblProductListing: UITableViewCell {
    
    @IBOutlet weak var lblLeft: UILabel!
    @IBOutlet weak var lblMiddle: UILabel!
    @IBOutlet weak var lblRight: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
