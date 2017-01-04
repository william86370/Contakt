//
//  contacts.swift
//  Contakt
//
//  Created by william wright  on 7/9/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class contacts: UITableViewController {
    
    
    var usernames = [""]
    var userids = [""]
    var isFollowing = [false]
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject("none", forKey: "run")

        
        
        
        
        
        
        super.viewDidLoad()
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let users = objects{
                self.usernames.removeAll(keepCapacity: true)
                self.userids.removeAll(keepCapacity: true)
                self.isFollowing.removeAll(keepCapacity: true)
                
                for objext in users {
                    if let user = objext as? PFUser{
                        
                        
                        
                        if user.objectId! != PFUser.currentUser()?.objectId{
                      self.usernames.append(user.username!)
                        self.userids.append(user.objectId!)
                            
                            var query = PFQuery(className: "followers")
                            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                            query.whereKey("following", equalTo: user.objectId!)
                            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                             
                                if let objects = objects {
                                    if objects.count > 0 {
                                        
                                     
                                        
                                    
                                    self.isFollowing.append(true)
                                }else{
                                self.isFollowing.append(false )
                                    
                                }
                                }
                                if self.isFollowing.count == self.usernames.count
                                {
                                
                                 self.tableView.reloadData()
                                }
                                
                            })
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
            }
            
            
            println(self.usernames)
            
           
        })
        
        
        
        

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        
        
        if isFollowing[indexPath.row] == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        cell.textLabel?.text = usernames[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        
        
        if isFollowing[indexPath.row] == false {
            
            isFollowing[indexPath.row] = true
        
        
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        var following = PFObject(className: "followers")
        following["following"] = userids[indexPath.row]
        following["follower"] = PFUser.currentUser()?.objectId
        following.saveInBackground()
        
        }else{
            
            isFollowing[indexPath.row] = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            
            
            var query = PFQuery(className: "followers")
            
            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
            query.whereKey("following", equalTo: userids[indexPath.row])
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if let objects = objects {
                    for object in objects {
                        
                        object.deleteInBackground()
                        
                        
                        
                    }
                
                
                }
                
            })
            
        }
        
    }

}
