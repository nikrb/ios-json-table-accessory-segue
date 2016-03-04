//
//  ViewController.swift
//  Cjson
//
//  Created by Nick Scott on 02/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DrillCompleteTableViewCellDelegate {

    @IBOutlet weak var drillTableView: UITableView! {
        didSet {
            drillTableView.delegate = self
            drillTableView.dataSource = self
        }
    }
    
    var selected_ndxpaths : [NSIndexPath]?
    var selected_ndx_path = NSIndexPath(forRow: 0, inSection: 0)
    var drill_grouped_list = [String: [Drill]]()
    var drill_section_titles = [String]()
    
    struct Drill {
        var _id:String?
        var type:String?
        var phase:String?
        var special:String?
        var name:String?
        var ref:String?
        var desc:String?
        var selected:Bool?
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        fetchData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
        let url = NSURL(string: "https://mongo-load-knik.c9users.io/")
        let request = NSURLRequest(URL: url!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error != nil {
                print(error)
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                    do {
                        if let json_data = try NSJSONSerialization.JSONObjectWithData(data!, options: [NSJSONReadingOptions.MutableContainers]) as? NSMutableArray {
                            var current_section = ""
                            for i in 0..<json_data.count {
                                let _id = json_data[i]["_id"] as! String
                                let name = json_data[i]["name"] as! String
                                let type = json_data[i]["type"] as! String
                                let phase = json_data[i]["phase"] as! String
                                let special = json_data[i]["special"] as! String
                                let ref = json_data[i]["ref"] as! String
                                let desc = json_data[i]["desc"] as! String
                                let drill = Drill(_id: _id, type: type, phase: phase, special: special, name: name, ref: ref, desc: desc, selected: false)
                                // table section grouping
                                let section = "\(type) \(phase)"
                                if section != current_section {
                                    current_section = section
                                    self.drill_grouped_list[section] = [Drill]()
                                    self.drill_section_titles.append( section )
                                }
                                self.drill_grouped_list[section]?.append( drill)
                            }
                        } else {
                            print( "data format incorrect?")
                        }
                    } catch {
                        print("data fetch failed")
                    }
                    dispatch_async(dispatch_get_main_queue()){
                        self.drillTableView.reloadData()
                    }
                })
            }
        }
        task.resume()
    }
    
    func drillCompleteChecked(sender: UIButton, isChecked : Bool) {
        let touchPoint = sender.convertPoint(CGPoint.zero, toView:drillTableView)
        let indexPath = drillTableView.indexPathForRowAtPoint(touchPoint)
        
        let section_title = self.drill_section_titles[indexPath!.section]
        let section = drill_grouped_list[section_title]
        
        var drill = section![indexPath!.row]
        print( "setting drill name [\(drill.name!)] selected [\(drill.selected!)] to [\(isChecked)]")
        drill.selected = isChecked
        print( "after setting selected is [\(drill.selected)]")
    }
    
    @IBAction func drillSelectDoneButton(sender: UIBarButtonItem) {
        selected_ndxpaths = drillTableView.indexPathsForSelectedRows
        print( "selected index paths [\(selected_ndxpaths)]")
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.drill_grouped_list.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row_count = 0
        let section_title = drill_section_titles[section]
        if let drills = drill_grouped_list[section_title] {
            row_count = drills.count
        }
        return row_count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let rcell = tableView.dequeueReusableCellWithIdentifier("drillCell", forIndexPath: indexPath)
        if let cell = rcell as? DrillCompleteTableViewCell {
        
            let section_title = self.drill_section_titles[indexPath.section]
            let section = drill_grouped_list[section_title]
            
            print( "cell for row [\(section![indexPath.row].name!)] at index path selected [\(section![indexPath.row].selected!)]")
            
            cell.drillNameLabel!.text = section![indexPath.row].name
            cell.delegate = self
            cell.setChecked( section![indexPath.row].selected!)
        }
        return rcell
    }
        
    
        
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return drill_section_titles[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.drill_section_titles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print( "@set selected ndx path section[\(indexPath.section)] row[\(indexPath.row)]")
        selected_ndx_path = indexPath
        /**
        Had to do it this way. When using storyboard accessory segue the prepareForSegue is called
        before we set the selected_ndx_path.
        I suspect this isn't the best way to do this, but it works for now as the table selection
        is disabled. If it weren't we need to presentViewController type method
        **/
        if let dest = storyboard?.instantiateViewControllerWithIdentifier("drillDetailView") as? DrillDetailViewController {
            let ndxpath = selected_ndx_path
            let section_title = self.drill_section_titles[ndxpath.section]
            if let section = drill_grouped_list[section_title] {
                dest.labelStrings[0] = section[ndxpath.row].type!
                dest.labelStrings[1] = section[ndxpath.row].phase!
                dest.labelStrings[2] = section[ndxpath.row].special!
                dest.labelStrings[3] = section[ndxpath.row].name!
                dest.labelStrings[4] = section[ndxpath.row].ref!
                dest.labelStrings[5] = section[ndxpath.row].desc!
            }
            presentViewController( dest, animated: true, completion: nil)
        }
        // performSegueWithIdentifier("AccessoryShowDrillDetail", sender: self)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToDrillList( sender : UIStoryboardSegue){
        print( "unwind to drill list")
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AccessoryShowDrillDetail" {
            print( "segue to drill detail")
            /*
            if let dest = segue.destinationViewController as? DrillDetailViewController {
                let ndxpath = selected_ndx_path
                let section_title = self.drill_section_titles[ndxpath.section]
                if let section = drill_grouped_list[section_title] {
                    dest.labelStrings[0] = section[ndxpath.row].type!
                    dest.labelStrings[1] = section[ndxpath.row].phase!
                    dest.labelStrings[2] = section[ndxpath.row].special!
                    dest.labelStrings[3] = section[ndxpath.row].name!
                    dest.labelStrings[4] = section[ndxpath.row].ref!
                    dest.labelStrings[5] = section[ndxpath.row].desc!
                }
            }*/
        }
    }
}
