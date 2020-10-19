//
//  hubListCell.swift
//  BlazeSdkTestApp
//
//  Created by Kapil Singh on 19/10/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit

class hubListCell: UITableViewCell {

    @IBOutlet weak var itemID: UILabel!
    @IBOutlet weak var titleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
