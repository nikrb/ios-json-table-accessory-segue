//
//  DrillDetailViewController.swift
//  Cjson
//
//  Created by Nick Scott on 02/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class DrillDetailViewController: UIViewController {
    
    var labelStrings = [String]( count: 6, repeatedValue: "n/a")
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet weak var specialLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var refLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typeLabel.text = labelStrings[0]
        phaseLabel.text = labelStrings[1]
        specialLabel.text = labelStrings[2]
        nameLabel.text = labelStrings[3]
        refLabel.text = labelStrings[4]
        descLabel.text = labelStrings[5]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
