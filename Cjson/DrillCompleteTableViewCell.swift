//
//  DrillCompleteTableViewCell.swift
//  Cjson
//
//  Created by Nick Scott on 03/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

protocol DrillCompleteTableViewCellDelegate {
    func click( button_parent : DrillCompleteTableViewCell)
}

class DrillCompleteTableViewCell: UITableViewCell {
    
    let unchecked = String( "\u{2b1c}")
    let checked = String( "\u{2705}")
    
    @IBOutlet weak var drillNameLabel: UILabel!
    @IBOutlet weak var drillCompleteButton: UIButton! {
        didSet {
            drillCompleteButton.setTitle(unchecked, forState: .Normal)
        }
    }
    
    var delegate:DrillCompleteTableViewCellDelegate?
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        <#code#>
    }
    
    @IBAction func completeButton(sender: UIButton) {
        print( "completion button clicked")
        delegate?.click(self)
    }
    
    func setChecked( check : Bool ){
        drillCompleteButton.setTitle( check ? checked : unchecked, forState: .Normal)
        drillCompleteButton.setTitle( check ? checked : unchecked, forState: .Selected )
        drillCompleteButton.setTitle( check ? checked : unchecked, forState: .Focused )
        drillCompleteButton.setTitle( check ? checked : unchecked, forState: .Highlighted )
    }
    
    func isChecked() -> Bool {
        return drillCompleteButton.titleLabel?.text == checked
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        drillCompleteButton.titleLabel?.text = checked
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
