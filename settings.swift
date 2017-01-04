//
//  settings.swift
//  Contakt
//
//  Created by william wright  on 8/6/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class settings: UITableViewController {
    
    //setings switchs 
    
    //private account switch 
    @IBOutlet var privateaccount: UISwitch!
    // turn on notifictions switch
    @IBOutlet var notifictions: UISwitch!
    //scan notifaction switch
    @IBOutlet var scan: UISwitch!
    //nearby alert notification switch
    @IBOutlet var nearby: UISwitch!
    //signout btn
    @IBOutlet var signoutbrn: UIButton!
   
    
    
    //ui activity views
    
    //private account activity
    @IBOutlet var privateaccountact: UIActivityIndicatorView!
    //turn on not activity
    @IBOutlet var notiactivity: UIActivityIndicatorView!
    //scan activity
    @IBOutlet var scanactivity: UIActivityIndicatorView!
    //nearby alert activity
    @IBOutlet var nearbyalertact: UIActivityIndicatorView!
    
   //switch change events after here
    
    //switch 1 change
    @IBAction func changed(sender: AnyObject) {
        privateaccount.hidden = true
        self.privateaccountact.startAnimating()
        
        if let currentUser = PFUser.currentUser(){
            if privateaccount.on {
                 currentUser["privateaccount"] = true
            }else{
                currentUser["privateaccount"] = false
            }
            currentUser.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.privateaccountact.stopAnimating()
                    self.privateaccount.hidden = false
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
    }
    
    //switch 2 
    @IBAction func turnonnoti(sender: AnyObject) {
        notifictions.hidden = true
        self.notiactivity.startAnimating()
        
        if let currentUser = PFUser.currentUser(){
            if notifictions.on {
                currentUser["turnonnoti"] = true
            }else{
                currentUser["turnonnoti"] = false
            }
            currentUser.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.notiactivity.stopAnimating()
                    self.notifictions.hidden = false
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }

        
    }
   
    //switch 3 
    @IBAction func scannoti(sender: AnyObject) {
        scan.hidden = true
        self.scanactivity.startAnimating()
        
        if let currentUser = PFUser.currentUser(){
            if scan.on {
                currentUser["scannoti"] = true
            }else{
                currentUser["scannoti"] = false
            }
            currentUser.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.scanactivity.stopAnimating()
                    self.scan.hidden = false
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
        
        
    }

    //switch 4
    @IBAction func nearbyalt(sender: AnyObject) {
        nearby.hidden = true
        self.nearbyalertact.startAnimating()
        
        if let currentUser = PFUser.currentUser(){
            if nearby.on {
                currentUser["nearbynoti"] = true
            }else{
                currentUser["nearbynoti"] = false
            }
            currentUser.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    self.nearbyalertact.stopAnimating()
                    self.nearby.hidden = false
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
        
        

        
    }
    
    
    
    
    
    

    override func viewDidLoad() {
        
        
        //when the user loads the page it starts the activity indacaters till settings load
        
        //these hides the switchs
        self.privateaccount.hidden = true
        self.notifictions.hidden = true
        self.scan.hidden = true
        self.nearby.hidden  = true
        //these start the activity state things
        self.privateaccountact.startAnimating()
        self.notiactivity.startAnimating()
        self.scanactivity.startAnimating()
        self.nearbyalertact.startAnimating()
        //here is where we ask parse for the info
        if let currentUser = PFUser.currentUser(){
            //private account switch
            if currentUser["privateaccount"] as? Bool != nil {
            if currentUser["privateaccount"] as? Bool == true {
                privateaccount.setOn(true, animated: false)
            }else{
                privateaccount.setOn(false, animated: false)
            }
            }
            
            //notifiaction switch
            if currentUser["turnonnoti"] as? Bool != nil {
            if currentUser["turnonnoti"] as? Bool == true {
                notifictions.setOn(true, animated: false)
            }else{
                notifictions.setOn(false, animated: false)
            }
            }
            //scan alert switch
            if currentUser["scannoti"] as? Bool != nil {
            if currentUser["scannoti"] as? Bool == true {
                scan.setOn(true, animated: false)
            }else{
                scan.setOn(false, animated: false)
            }
            }
            //nearby alert switch
            if currentUser["nearbynoti"] as? Bool != nil {
            if currentUser["nearbynoti"] as? Bool == true {
                nearby.setOn(true, animated: false)
            }else{
                nearby.setOn(false, animated: false)
            }
            }
            //here we stop the activity indacaters
            self.privateaccountact.stopAnimating()
            self.notiactivity.stopAnimating()
            self.scanactivity.stopAnimating()
            self.nearbyalertact.stopAnimating()
            //here we unhide the switchs
            self.privateaccount.hidden = false
            self.notifictions.hidden = false
            self.scan.hidden = false
            self.nearby.hidden  = false
            
            
            
        }
        
        
        
        
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        //return 2
   // }

    //override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return 0
   // }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
}
