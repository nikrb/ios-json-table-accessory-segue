//
//  ViewController.swift
//  Cjson
//
//  Created by Nick Scott on 02/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DrillCompleteTableViewCellDelegate {

    var selected_drill : Drill?
    
    @IBOutlet weak var drillTableView: UITableView! {
        didSet {
            drillTableView.delegate = self
            drillTableView.dataSource = self
        }
    }
    
    struct Drill {
        var name:String?
        var selected:Bool?
    }
    
    var test_data = [Drill]()
    
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
    
    // MARK: Actions
    @IBAction func doneButton(sender: UIBarButtonItem) {
        for i in 0..<6 {
            let drill = test_data[i]
            print( "drill name[\(drill.name)] selected[\(drill.selected)]")
        }
    }
    
    // MARK: DrillCompleteTableViewCellDelegate
    func drillCompleteChecked(sender: UIButton, isChecked : Bool) {
        let touchPoint = sender.convertPoint(CGPoint.zero, toView:drillTableView)
        let indexPath = drillTableView.indexPathForRowAtPoint(touchPoint)
        
        var drill = test_data[indexPath!.row]
        drill.selected = isChecked
        
        print( "@ViewController.drillCompleteChecked drill selected is [\(drill.selected)]")
        
        // segue works with correct value for drill.selected
        selected_drill = drill
        // TODO: this version doesn't show nav bar or cancel bar item button
        // without nav controller default back button doesn't show either
        // let nvc = storyboard?.instantiateViewControllerWithIdentifier("SegueTestViewController")
        // presentViewController( nvc!, animated: true, completion: nil)
        
        // TODO: This works using a dummy segue identifier, selected is retained on segue return
        performSegueWithIdentifier( "ShowTestSegue", sender: self)
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
            // FIXME: drill selected loses its value
            cell.setChecked( drill.selected!)
        }
        return rcell
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print( "@set selected ndx path section[\(indexPath.section)] row[\(indexPath.row)]")
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // TODO: drill selected is set correct here!
        print( "@prepare for segue id[\(segue.identifier)] for drill:", selected_drill  )
    }
    
    @IBAction func unwindToDrillList( sender : UIStoryboardSegue){
        print( "unwind to drill list")
    }
    
}
