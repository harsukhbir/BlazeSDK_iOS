//
//  ListCell.swift
//  BlazeSdkTestApp
//
//  Created by Ram on 24/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var enableSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
