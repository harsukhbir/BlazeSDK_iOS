//
//  SensorCell.swift
//  BlazeSdkTestApp
//
//  Created by nisha gupta on 05/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class SensorCell: UITableViewCell {

    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var lbl_Status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
