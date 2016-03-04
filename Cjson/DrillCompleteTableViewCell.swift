//
//  DrillCompleteTableViewCell.swift
//  Cjson
//
//  Created by Nick Scott on 03/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

protocol DrillCompleteTableViewCellDelegate {
    func drillCompleteChecked( sender : UIButton, isChecked:Bool)
}

class DrillCompleteTableViewCell: UITableViewCell {
    var delegate:DrillCompleteTableViewCellDelegate?
    
    let unchecked = String( "\u{2b1c}")
    let checked = String( "\u{2705}")
    
    @IBOutlet weak var drillNameLabel: UILabel!
    @IBOutlet weak var drillCompleteButton: UIButton! {
        didSet {
            drillCompleteButton.setTitle(unchecked, forState: .Normal)
            drillCompleteButton.addTarget( self, action: Selector( "completeButton:"), forControlEvents: .TouchUpInside)
        }
    }
    
    @IBAction func completeButton( sender : UIButton){
        let check = isChecked() ? false : true
        setChecked( check)
        delegate?.drillCompleteChecked( sender, isChecked: check)
    }
    
    func setChecked( check : Bool ){
        drillCompleteButton.setTitle( check ? checked : unchecked, forState: .Normal)
    }
    
    func isChecked() -> Bool {
        var ret = false
        if let txt = drillCompleteButton.titleLabel?.text {
            print( "table view cell is checked [\(txt)]")
            if txt == checked {
                ret = true
            }
        }
        return ret
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
