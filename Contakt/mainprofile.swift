//
//  mainprofile.swift
//  Contakt
//
//  Created by william wright  on 7/8/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse


class mainprofile: UIViewController {
    
    
    var ID  = ""
    
    
    
    @IBOutlet var usernamepro: UILabel!
    
    @IBOutlet var citypro: UILabel!
    
    @IBOutlet var followerspro: UILabel!
    
    @IBOutlet var followingpro: UILabel!
    
    @IBOutlet var emailpro: UILabel!
    
    @IBOutlet var phonepro: UILabel!
    
    @IBOutlet var facebookpro: UILabel!
    
    @IBOutlet var twitteraccountpro: UILabel!
    
    

    
    
    
    
    
    
    

    override func viewDidLoad() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("ID")
        {
            var ID  = name
        }
        
        
        var query = PFQuery(className:"profile")
        query.getObjectInBackgroundWithId(ID) {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                self.usernamepro.text = gameScore?["username"] as? String
                
                self.emailpro.text = gameScore?["email"] as? String
                
                self.phonepro.text = gameScore?["phone"] as? String
                
                
                
                
                
                
                
                
                println(gameScore)
            } else {
                println(error)
            }
            
            
        }
        

                                super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
