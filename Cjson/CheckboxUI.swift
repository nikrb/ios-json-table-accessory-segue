//
//  CheckboxUI.swift
//  Checkbox
//
//  Created by Nick Scott on 02/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class CheckboxUI: UILabel {
    let unchecked = String( "\u{2b1c}")
    let checked = String( "\u{2705}")
    
    func toggleCheckBox( sender : UILabel){
        if self.text == checked {
            self.text = unchecked
        } else {
            self.text = checked
        }
    }
    
    func setChecked( check : Bool){
        if check {
            self.text = checked
        } else {
            self.text = unchecked
        }
    }
    
    func isChecked() -> Bool {
        if self.text == checked {
            return true
        } else {
            return false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        toggleCheckBox( self)
    }
    
    override func drawTextInRect(rect: CGRect) {
        if self.text != checked && self.text != unchecked {
            self.text = unchecked
        }
        super.drawTextInRect(rect)
    }
}
