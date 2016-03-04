//
//  ViewController.swift
//  Cjson
//
//  Created by Nick Scott on 02/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DrillCompleteTableViewCellDelegate {

    @IBOutlet weak var testButton: UIButton!
    
    @IBOutlet weak var drillTableView: UITableView! {
        didSet {
            drillTableView.delegate = self
            drillTableView.dataSource = self
        }
    }
    
    func buttonTitleChanged( sender: AnyObject){
        print( "button title changed to [\(testButton.titleLabel?.text!)]")
    }
    
    @IBAction func testButton(sender: UIButton) {
        sender.setTitle("M", forState: .Normal)
    }
    
    var selected_ndx_path : NSIndexPath?
    var test_data = [Drill]()
    
    struct Drill {
        var name:String?
        var selected:Bool?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataTest()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fetchDataTest(){
        for i in 10..<90{
            let d = Drill( name: "row\(i)", selected: false)
            test_data.append(d)
        }
    }
    
    func drillCompleteChecked(sender: UIButton, isChecked : Bool) {
        let touchPoint = sender.convertPoint(CGPoint.zero, toView:drillTableView)
        let indexPath = drillTableView.indexPathForRowAtPoint(touchPoint)
        
        var drill = test_data[indexPath!.row]
        drill.selected = isChecked
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rcell = tableView.dequeueReusableCellWithIdentifier("drillCell", forIndexPath: indexPath)
        if let cell = rcell as? DrillCompleteTableViewCell {
            
            let drill = test_data[indexPath.row]
            
            cell.drillNameLabel!.text = drill.name
            cell.delegate = self
            cell.setChecked( drill.selected!)
            
            
        }
        return rcell
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print( "@set selected ndx path section[\(indexPath.section)] row[\(indexPath.row)]")
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToDrillList( sender : UIStoryboardSegue){
        print( "unwind to drill list")
    }
    
}
