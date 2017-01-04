//
//  testview.swift
//  Contakt
//
//  Created by william wright  on 8/3/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class testview: UIViewController {
    
    @IBOutlet var namebox: UITextField!
    
    @IBOutlet var emailbox: UITextField!
    
    @IBOutlet var phonebox: UITextField!
    
    @IBOutlet var facebook: UITextField!
    
    
   
    
    
    
    
  
    
    
    
    
    
    
    
    
    
    @IBAction func finnish(sender: AnyObject) {
        if let currentUser = PFUser.currentUser(){
            currentUser["email"] = emailbox.text
            currentUser["Name"] = namebox.text
            currentUser["phone"] = phonebox.text
            currentUser["facebook"] = facebook.text
            
            //set other fields the same way....
            currentUser.saveInBackground()
        }
    }
    
    

    override func viewDidLoad() {
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
