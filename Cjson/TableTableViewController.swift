//
//  TableTableViewController.swift
//  Cjson
//
//  Created by Nick Scott on 01/03/2016.
//  Copyright © 2016 Nick Scott. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    var drill_list = [Drill]()
    
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
        print( "starting request")
        let url = NSURL(string: "https://mongo-load-knik.c9users.io/")
        let request = NSURLRequest(URL: url!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, responce, error) -> Void in
            print( "@dataTaskWithRequest")
            if error != nil {
                print(error)
            } else {
                do {
                    if let json_data = try NSJSONSerialization.JSONObjectWithData(data!, options: [NSJSONReadingOptions.MutableContainers]) as? NSMutableArray {
                        for i in 0..<json_data.count {
                            let _id = json_data[i]["_id"] as! String
                            let name = json_data[i]["name"] as! String
                            let type = json_data[i]["type"] as! String
                            let phase = json_data[i]["phase"] as! String
                            let special = json_data[i]["special"] as! String
                            let ref = json_data[i]["ref"] as! String
                            let desc = json_data[i]["desc"] as! String
                            let d = Drill(_id: _id, type: type, phase: phase, special: special, name: name, ref: ref, desc: desc)
                            self.drill_list.append( d)
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
        print( "request sent, I presume")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drill_list.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("drillCell", forIndexPath: indexPath)
        
        let drill = self.drill_list[indexPath.row]
        
        cell.textLabel?.text = drill.name
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
