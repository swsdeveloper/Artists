//
//  ArtMovementViewController.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import UIKit

// This is the Root View Controller

class ArtMovementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate, NSURLConnectionDelegate {
    
    //the table view for this controller has Data Source and Delegate connections to this controller
    //thus, data for this table comes from this controller
    //and callback methods are defined and occur in this controller
    
    @IBOutlet var tableView: UITableView!  //connects the CompanyViewController's table view to the controller
 
    
    // The following are properties of an ArtMovementViewController
    
    var url = NSURL(string:"")
    var response: NSData?
    var dataInit = DataInit()
    var data = NSMutableData()
    var artMovements: [ArtMovement]?
    
    var rowHeight:Int = 88  // The ArtMovementViewController's UITable's row height is set in the storyboard
   
    // When view loads:
    //  - register all cells in the corresponding table view for reuse...
    //    ...this goes hand-in-hand with the tableView:cellForRowAtIndexPath callback method's dequeueReusableCellWithIdentifier method (see below)
    //  - set this object's artMovements array to the DataInit object's artMovements array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"cell")
        self.artMovements = self.dataInit.getartMovements()
        
        if self.tableView.rowHeight < CGFloat(rowHeight) { rowHeight = 44 }
    }
 
    
    // Just before the view is displayed:
    //  - create a local array of the stock symbols for each company
    //  - append all the symbols together, separating each with a "+", in stockSymbolString
    //  - looks up all the stock prices via a single call to the Yahoo Finance website
    //  - Yahoo returns a CSV file, with each stock price on a line by itself
    
    override func viewWillAppear(animated: Bool) {
//        var stockArray:Array<String> = []
//        for (var i = 0; i < self.companies?.count ; i++) {
//            var company = self.companies![i]
//            stockArray.append(company.stockSymbol!)
//        }
//        
//        var stockSymbolString = ""
//        for stockSymbol in stockArray {
//            stockSymbolString += stockSymbol + "+"  // we'll end up with sym1+sym2+...+symN+ -- we need to remove the trailing +
//        }
//        
//        stockSymbolString = stockSymbolString.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "+"))
//        // removes trailing "+" sign
//        
//        var urlAsString = "http://finance.yahoo.com/d/quotes.csv?s=\(stockSymbolString)&f=a"
//        
//        var url = NSURL(string:urlAsString)
//        var request = NSURLRequest(URL:url)
//        var connection = NSURLConnection(request: request, delegate:self, startImmediately: true)   // see NSURLConnection callback methods below
    }
 
    
    // ************************************
    // * NSURLConnection Callback Methods *
    // ************************************
    
    // called when the above Yahoo lookup returns a response
    // we clear the data property (of our CompanyViewController object) so it can be appended to by the next method
    
//    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
//        self.data = NSMutableData()
//    }
//    
    // called when the above Yahoo lookup returns the next portion of its data (i.e., a CSV file)
    // we append the latest data to self.data
    
//    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
//        self.data.appendData(data)
//        //println(self.data)
//    }
    
    // called when the above Yahoo lookup has finished returning all of its data
    // copy self.data (which was built by the previous 2 callbacks) to local var dta and convert it to a string
    // Then copy each element of the string (i.e., each stock price) into a stockPriceArray
    // Then copy each stock price from the stockPriceArray into the corresponding DataInit object's companies array
    // Reload the view to display the stock prices
    
//    func connectionDidFinishLoading(connection: NSURLConnection!) {
//        var dta:String = NSString(data: data, encoding: NSUTF8StringEncoding)
//        
//        //println(dta)
//        
//        dta = dta.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\n")) // remove lead/trailing linefeeds (if any)
//        
//        var stockPriceArray:[String] = dta.componentsSeparatedByString("\n")  // get each stock price in an array
//        
//        for (var i = 0; i < stockPriceArray.count; i++) {
//            self.artists![i].stockPrice = stockPriceArray[i]
//        }
//        
//        self.tableView.reloadData()
//    }

    // called while our Yahoo request is being submitted. This callback lets us display the progress of our upload
    // For some reason, this function does not get called???

//    func connection(connection: NSURLConnection!, didSendBodyData bytesWritten: Int, totalBytesWritten: Int, totalBytesExpectedToWrite: Int) {
//            println("percent complete: \(totalBytesWritten / totalBytesExpectedToWrite)")
//    }

    
    // *******************************
    // * Table View Callback Methods *
    // *******************************
    
    // returns total # of table rows that we need for the specified section (our app only has 1 section)
    // (Not all rows may be displayed at the same time; only as many rows as can fit on the screen.
    // You have to scroll to see the other rows.)
    
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artMovements!.count
    }
    

    /*  Builds and returns a single cell
    
        At entry: function rcvs a table view and the index of a specific row in the table
    
        Process:
            ArtMovement (a local var) is set to the ArtMovement object (fm the DataInit artMovements array) that corresponds to the passed index (i.e., the row index)
            a cell is built by assigning it:
                a text label: the ArtMovement object's name)
                an image: from the corresponding jpeg file included in the project
    
        - dequeueReusableCellWithIdentifier -- Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.
    */

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var ArtMovement = self.artMovements![indexPath.row]
 
        cell.textLabel.text = "\(ArtMovement.title!)"
        
        var imageName = "\(ArtMovement.name!)\(rowHeight)" + ".jpg"
        var image = UIImage(named:"\(imageName)")
        
        cell.backgroundColor = ArtMovement.color!
        
        cell.imageView.image = image
        
        return cell
    }

    
    // When user selects an ArtMovement (from the displayed table), this function switches to the Artist view for the selected ArtMovement
    // For navigation purposes, each view controller is pushed onto a stack.
    // When user hits Back button, the current view is popped and the previous view is restored (automatically)
    // We only need to push views; iOS auto pops them

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let artistViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ArtistViewController") as ArtistViewController
        
        artistViewController.artMovement = self.artMovements![indexPath.row]  // sets ArtMovement property of ArtistViewController object
        
        artistViewController.title = self.artMovements![indexPath.row].title! + " Artists"

        self.navigationController!.pushViewController(artistViewController, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        println("ArtMovementViewController - didReceiveMemoryWarning")
   }
    
}

