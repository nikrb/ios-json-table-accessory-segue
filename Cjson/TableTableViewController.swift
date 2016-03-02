//
//  TableTableViewController.swift
//  Cjson
//
//  Created by Nick Scott on 01/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var selected_ndx_path : NSIndexPath?
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
    }
    
    @IBOutlet var drillTableView: UITableView!
    
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
                            let drill = Drill(_id: _id, type: type, phase: phase, special: special, name: name, ref: ref, desc: desc)
                            // table section grouping
                            let section = "\(type) \(phase)"
                            if section != current_section {
                                print( "new section [\(section)]")
                                current_section = section
                                self.drill_grouped_list[section] = [Drill]()
                                self.drill_section_titles.append( section )
                            }
                            self.drill_grouped_list[section]?.append( drill)
                        }
                        self.drillTableView.reloadData()
                    } else {
                        print( "data format incorrect?")
                    }
                } catch {
                    print("data fetch failed")
                }
            }
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.drill_grouped_list.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row_count = 0
        let section_title = drill_section_titles[section]
        if let drills = drill_grouped_list[section_title] {
            row_count = drills.count
        }
        return row_count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("drillCell", forIndexPath: indexPath)
        
        let section_title = self.drill_section_titles[indexPath.section]
        let section = drill_grouped_list[section_title]
        
        cell.textLabel?.text = section![indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return drill_section_titles[section]
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.drill_section_titles
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    
    @IBAction func unwindToTableView( sender:UIButton){
        print("unwindToTableView")
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        selected_ndx_path = indexPath
        print( "table view accessory selected")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print( "prepare for seque [\(segue.identifier)]")
        if segue.identifier == "ShowDrillDetail" {
            if let dest = segue.destinationViewController as? DrillDetailViewController {
                if let ndxpath = selected_ndx_path {
                    let section_title = self.drill_section_titles[ndxpath.section]
                    let section = drill_grouped_list[section_title]
                    
                    dest.typeLabel.text = section![ndxpath.row].type
                    dest.phaseLabel.text = section![ndxpath.row].phase
                    dest.specialLabel.text = section![ndxpath.row].special
                    dest.nameLabel.text = section![ndxpath.row].name
                    dest.refLabel.text = section![ndxpath.row].ref
                    dest.descLabel.text = section![ndxpath.row].desc
                }
            }
        }
    }
}
