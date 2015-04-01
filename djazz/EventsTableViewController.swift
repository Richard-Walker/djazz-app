//
//  EventsTableViewController.swift
//  djazz
//
//  Created by Richard Walker on 15/02/15.
//  Copyright (c) 2015 Bright Moods Studios. All rights reserved.
//

import UIKit
import Alamofire

class EventsTableViewController: UITableViewController, UITableViewDataSource, EventCellDelegates, EventDelegates, NetworkDelegates {
    
    
    
    // MARK: - Properties -------------------------------------------------------------------
    
    /// The model of this view: a list of JSON events
    var events = Events()
    
    
    
    // MARK: - Protocol EventDelegates & NetworkDelegates ----------------------------------------------
    
    func eventHapenned(event: Event) {
        // An event has been triggered, we refresh the corresponding row in the view
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: event.index!, inSection: 0)], withRowAnimation: .None)
    }
    
    func networkErrorOccurred(message:String, error: NSError) {
        // A network error has occurred, we display a popup in the current view to inform the user
        self.error(error, message: message)
    }
    
    
    
    // MARK: - View notifications -------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Wire deleguates
        events.delegates = self
        events.netDelegates = self
        
        // Trick to not display empty cells
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Load events and refresh view when done
        events.load { self.tableView!.reloadData() }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source -------------------------------------------------------------------
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // get event from model
        let event = events[indexPath.row]

        // detach cell
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCellPrototype", forIndexPath: indexPath) as EventCell
        
        // render cell according to model
        cell.nameLabel.text = event.title
        cell.toggle.on = event.enabled
        cell.timeLabelButton.setTitle(event.time.timePart, forState: .Normal)
        cell.progressView.progress = 0
        cell.active = event.enabled
        cell.rowIndex = indexPath.row
        cell.deleguate = self
        
        return cell
    }

    
    
    // MARK: - Protocol EventCellDeleguate -------------------------------------------------------------------
    
    func eventActivated(cell: EventCell) {

        // get event from model
        var event = events[cell.rowIndex]
        
        // define updates
        let updates = [ "enabled" : true, "time" : NSDate.nextOccurenceOf(event.time.timePart) ]
        
        // update model and adapt the view when done
        // TODO: try by re-disabling button first and not using error callback
        event.update(updates,
            {
                cell.active = true
            } ,
            errorCallback: {
                cell.active = false
            }
        )
    }
    
    func eventDeactivated(cell: EventCell) {

        // get event from model
        var event = events[cell.rowIndex]
        
        // define updates
        let updates = [ "enabled" : false ]
        
        // update model and adapt the view when done
        // TODO: try by re-enabling button first and not using error callback
        event.update(updates,
            {
                cell.active = false
            } ,
            errorCallback: {
                cell.active = true
            }
        )
        
    }

    
    
    // MARK: - Navigation -------------------------------------------------------------------
    
    @IBAction func unwindToEventList(seague: UIStoryboardSegue) {
        
        if let source = seague.sourceViewController as? EditEventViewController {
            if source.chosenTime != nil {

                // get cell
                var cell = source.eventCell!
                
                // get event from model
                var event = events[cell.rowIndex]
                
                // define updates
                let updates = [ "time" : NSDate.nextOccurenceOf(source.chosenTime!) ]
                
                // update model and adapt the view when done
                // TODO: try by re-enabling button first and not using error callback
                event.update(updates) {
                    cell.timeLabelButton.setTitle(source.chosenTime, forState: .Normal)
                }

            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // If destination is edit event, pass the cell to be edited to the new controller
        if let destination = segue.destinationViewController as? EditEventViewController {
            if let cell = (sender as? UIView)?.superview?.superview? as? EventCell {
                destination.eventCell = cell
            } else {
                self.alert("Error", message: "Could not find the cell object to update", buttonText: "Ok")
            }
        }
    
    }


    
    // MARK: - Commented xcode boiler plate code -------------------------------------------------------------------
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


}
