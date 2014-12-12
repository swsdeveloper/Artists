//
//  ArtistDetailViewController.swift
//  artists3
//
//  Created by Steven Shatz on 8/12/14.
//  Copyright (c) 2014 Steven Shatz. All rights reserved.
//

import UIKit
import WebKit

class ArtistDetailViewController: UIViewController, UIScrollViewDelegate {
    
    //This view controller inherits the properties and functions of UIViewController (but needs no delegates or source data protocols)
    //When this was created (by ArtistViewController's tableView:didSelectRowAtIndexPath method), the artist property was set
    
    // The following are properties of a ArtistDetailViewController
    
    var artist: Artist?
    
    //var image: UIImage?           // for testing with image instead of webview
    //var imageView: UIImageView?   // for testing with image instead of webview

    
    // @IBOutlet var containerView : UIView! = nil     //connects the ArtistDetailViewController's Web view to the controller
    
    @IBOutlet var scrollView: UIScrollView?
    @IBOutlet var webView: UIWebView?
    
    var saveWebViewSize:CGSize?
   
    
    //var webView: WKWebView?      //for iOS 8 and later
    //var webView: UIWebView?      //for iOS 7.1 and earlier


    // This is used in lieu of init()
    // - creates an empty Web View
    // - sets the ArtistDetailViewController's view to the empty web view (note: view  is a property of UIViewController)
    // - sets the ArtistDetailViewController's title to the artist's name (note: title is a property of UIViewController)
    
    override func loadView() {
        super.loadView()
        
        //println("loadView")
        
        // Set up scrollView
       
        /*
        Put a UIScrollView in the main view, then put the web view in the scroll view.
        Implement <UIScrollViewDelegate> in this view controller, drag the scroll view delegate to the view controller in Interface Builder, and implement the viewForZoomingInScrollView method. This must return the pointer to the UIScrollView (return myScrollView).
        Create IBOutlet properties for both the web view and the scroll view - link them in the NIB to your view controller.
        On the Scroll View, go to the Attributes Inspector, set your Max and Min zoom factors (Set 0.5 to 5.0, that works well).
        On the Web View, in the Attributes Inspector:
            In the Web View section, select Scales Pages To Fit
            In the View section, select for Mode, "Top Left"
            In the View section at the bottom, check off User Interaction Enabled and Multiple Touch Enabled
        */
    

        //image = UIImage(named: "naive.jpg")       // for testing with image instead of webview
        //imageView = UIImageView(image: image)     // for testing with image instead of webview
    
        
        //self.webView = WKWebView()      //for iOS 8 and later
        //self.webView = UIWebView()      //for iOS 7.1 and earlier
        
        
        //self.scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)   // if we didn't already have an outlet
        
        self.scrollView?.contentSize = webView!.bounds.size
        saveWebViewSize = self.scrollView?.contentSize
        
        self.scrollView?.delegate = self
        
        self.scrollView?.contentInset.top = 30
        self.scrollView?.contentInset.bottom = 30
        
        // self.scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        
        self.scrollView?.scrollEnabled = true
        
        self.scrollView?.minimumZoomScale = 0.5
        self.scrollView?.maximumZoomScale = 5.0
        self.scrollView?.directionalLockEnabled = false     // default
      
        
        self.webView?.scalesPageToFit = true          // fit width of screen
        
        
        //self.scrollView?.addSubview(imageView!)     // put the ImageView in the ScrollView - for testing with image instead of webview
        
        self.scrollView?.addSubview(webView!)       // put the WebView in the ScrollView
        
        self.view = self.scrollView!                 // put the ScrollView in the main view

        
        self.title = self.artist!.name
        
        /*  estimatedProgress - a property of WKWebView - An estimate of what fraction of the current navigation has been completed.
            This value ranges from 0.0 to 1.0 based on the total number of bytes expected to be received, including the main document
            and all of its potential subresources. After a navigation completes, the value remains at 1.0 until a new navigation starts,
            at which point it is reset to 0.0.
        */
        //println("Estimated webView progress A: \(self.webView!.estimatedProgress)") // This always shows 0.0
    }
    
    // When view loads:
    //  - do website lookup - there are no callbacks. If user hits back button before web view loads, nothing is shown and nothing happens
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //println("viewDidLoad")
        
        var url = NSURL(string:self.artist!.url!)    //set url to the url property of the Artist object
        
        var cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var timeoutInterval = NSTimeInterval(3.0) // 3 seconds
        var req = NSURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        
        self.webView!.loadRequest(req)              //invoke the url request to set this ArtistDetail object's webView

        //println("Estimated webView progress B: \(self.webView!.estimatedProgress)") // This always shows 0.1
    }

    
    func webViewDidFinishLoad(webView: UIWebView!)  {
        println("webViewDidFinishLoad") // never occurs - why?

        self.webView!.scrollView.scrollEnabled = false
        
        let output = webView.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight + document.body.offsetTop;")
        let contentHeight = (output! as NSString).floatValue
        
        self.scrollView?.contentSize.height = CGFloat(contentHeight)
        
        //self.scrollView?.contentSize = saveWebViewSize!
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! { // return a view that will be scaled. if delegate returns nil, nothing happens
        
        println("viewForZoomingInScrollView")
        
        //return self.imageView // for testing with image instead of webview
        
        self.webView!.scrollView.scrollEnabled = false

        return self.webView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView!, withView view: UIView!, atScale scale: CGFloat) {
        println("scrollViewDidEndZooming")
        
        // what should we do here?
        
        //let output = webView!.stringByEvaluatingJavaScriptFromString("document.body.offsetHeight;")
        //let contentHeight = (output as NSString).floatValue
        
        //self.scrollView?.contentSize.height = CGFloat(contentHeight)
        //self.scrollView?.contentSize = view.bounds.size
        
        //self.scrollView?.contentSize = saveWebViewSize!
        
        //self.webView?.bounds.size.width = webView!.bounds.size.width * scale
        //self.webView?.bounds.size.height = webView!.bounds.size.height * scale
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("ArtistDetailViewController - didReceiveMemoryWarning")
    }
    
}