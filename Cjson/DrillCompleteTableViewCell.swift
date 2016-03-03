//
//  DrillCompleteTableViewCell.swift
//  Cjson
//
//  Created by Nick Scott on 03/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

protocol DrillCompleteCheckboxDelegate {
    func didSelectCheckboxAtIndex( sender:CheckboxUI, index_path:NSIndexPath)
}

class DrillCompleteTableViewCell: UITableViewCell, CheckboxUIDelegate {

    @IBOutlet weak var drillNameLabel: UILabel!
    @IBOutlet weak var completeCheckbox: CheckboxUI! {
        didSet {
            completeCheckbox.delegate = self
        }
    }
    var delegate : DrillCompleteCheckboxDelegate?
    
    func didSelectCheckbox( sender:CheckboxUI, index_path: NSIndexPath) {
        print( "checkbox selected section[\(index_path.section)] row[\(index_path.row)]")
        delegate?.didSelectCheckboxAtIndex( sender, index_path: index_path)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
