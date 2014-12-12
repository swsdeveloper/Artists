//
//  ArtistViewController.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //the table view for this controller has Data Source and Delegate connections to this controller
    //thus, data for this table comes from this controller
    //and callback methods are defined and occur in this controller
    
    //When this was created (by ArtMovementViewController's tableView:didSelectRowAtIndexPath method), the artMovement property was set
    
    @IBOutlet var tableView: UITableView!       //connects the ArtistViewController's table view to the controller

    
    // The following are properties of an ArtistViewController
    
    var artMovement:ArtMovement? = nil
 
    
    // When view loads:
    //  - define this view controller as both the Delegate and Data Source for the related tableview (see IBOutlet above)
    //    -- this is redundant since these relations were also set up in the storyboard
    //  - register all cells in the corresponding table view for reuse...
    //    ...this goes hand-in-hand with the tableView:cellForRowAtIndexPath callback method's dequeueReusableCellWithIdentifier method (see below)
    //  - Sets up an Edit Button on the right side of the Navigation Control

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self      // redundant since established by storyboard
        self.tableView.dataSource = self    // redundant since established by storyboard
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    // *******************************
    // * Table View Callback Methods *
    // *******************************
    
    // returns total # of table rows that we need for the specified section (our app only has 1 section)
    // (Not all rows may be displayed at the same time; only as many rows as can fit on the screen.
    // You have to scroll to see the other rows.)
    // The total # of rows we need = the total # of Artists associated with this artMovement
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artMovement!.artists.count
    }

    
    /*  Builds and returns a single cell
    
        At entry: function rcvs a table view and the index of a specific row in the table
    
        Process:
        - product (a local var) is set to the Artist object (fm the DataInit artmovements' array) that corresponds to the passed index (i.e., the row index)
        - a cell is built by assigning it a text label: the Artist object's name
    
        - dequeueReusableCellWithIdentifier -- Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var artist = self.artMovement!.artists[indexPath.row]
        cell.textLabel.text = artist.name
        
        let color = artMovement!.color!
        cell.textLabel.textColor = color
        
//        if color == UIColor.yellowColor() || color == UIColor.greenColor() || color == UIColor.cyanColor() {
//            cell.backgroundColor = UIColor.blackColor()
//        }
        
        return cell
    }
    
    // When user swipes right, the table permits the current Artist to be deleted
    // Though not done here, this method also supports Inserting an item in the table
    //
    // We both remove the item from the ArtMovement's artists array (i.e., the data source) and the tableView itself

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        self.artMovement?.artists.removeAtIndex(indexPath.row)
        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        //self.tableView.reloadData() -- not needed
    }
    
    // When user selects an Artist (from the displayed table), this function switches to the Artist Detail view for the selected Artist
    // For navigation purposes, each view controller is pushed onto a stack.
    // When user hits Back button, the current view is popped and the previous view is restored (automatically)
    // We only need to push views; iOS auto pops them
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var artist = self.artMovement!.artists[indexPath.row]
        
        let artistDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ArtistDetailViewController") as ArtistDetailViewController
        
        artistDetailViewController.artist = artist
        
        self.navigationController!.pushViewController(artistDetailViewController, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        println("ArtistViewController - didReceiveMemoryWarning")
    }
    
}


