//
//  DrillCompleteTableViewCell.swift
//  Cjson
//
//  Created by Nick Scott on 03/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class DrillCompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var drillNameLabel: UILabel!
    @IBOutlet weak var completeCheckbox: CheckboxUI!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
