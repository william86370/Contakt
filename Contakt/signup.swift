//
//  signup.swift
//  Contakt
//
//  Created by william wright  on 7/9/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class signup: UIViewController, UITextFieldDelegate {

    @IBOutlet var usernamebox: UITextField!
    
    @IBOutlet var emailbox: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var confirmoassword: UITextField!
    
    @IBAction func register(sender: AnyObject) {
        myMethod()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    func myMethod() {
        
        
        
        
        var user = PFUser()
        user.username = usernamebox.text
        user.password = password.text
        user.email = emailbox.text
        
        
        // other fields can be set just like with PFObject
        
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? String
                
                let alertController = UIAlertController(title: "Something Went Wrong", message:
                    errorString, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                // Show the errorString somewhere and let the user try again.
            } else {
                print("signedup")
                self.performSegueWithIdentifier("done", sender: self)
                
                
            }
        }
    }
    
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
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
