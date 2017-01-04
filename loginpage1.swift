//
//  loginpage1.swift
//  Contakt
//
//  Created by william wright  on 7/7/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse



class loginpage1: UIViewController,UITextFieldDelegate {
    
   
    @IBOutlet var rememeber: UISwitch!
  
    
    @IBOutlet var usernamefield: UITextField!
    
    @IBOutlet var passwordfield: UITextField!
    
    @IBOutlet var facebooklogin: UIButton!
    
    
    @IBOutlet var loginbtn: UIButton!
    
    
    
    
    
    @IBAction func facebooklogin(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "email", "user_friends","user_location","user_photos"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                    
                    self.performSegueWithIdentifier("loginyes", sender: self)
                } else {
                    println("User logged in through Facebook!")
                    self.performSegueWithIdentifier("loginyes", sender: self)
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
                let alertController = UIAlertController(title: "Facebook Login Failed", message:
                    "Facebook Login Failed", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
              
            }
        }
    }
    
    //check for internet connection method 
    func checkInternet(flag:Bool, completionHandler:(internet:Bool) -> Void)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = NSURL(string: "http://www.google.com/")
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        NSURLConnection.sendAsynchronousRequest(request, queue:NSOperationQueue.mainQueue(), completionHandler:
            {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                let rsp = response as! NSHTTPURLResponse?
                
                completionHandler(internet:rsp?.statusCode == 200)
        })
    }
    
    
    
    
   
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    @IBAction func login(sender: UIButton) {
        view.endEditing(true)
        SwiftSpinner.show("Logging You in Please Wait...")
        SwiftSpinner.showWithDelay(8.0, title: "Checking for network issues")
        
        PFUser.logInWithUsernameInBackground(usernamefield.text, password:passwordfield.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                // Do stuff after successful login.
                SwiftSpinner.hide()
                let defaults = NSUserDefaults.standardUserDefaults()
                
                defaults.setObject(self.usernamefield.text, forKey: "username1")
                defaults.setObject(self.passwordfield.text, forKey: "password2");                println("loged itn")
                if self.rememeber.on{
                    
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    defaults.setObject(self.usernamefield.text, forKey: "username1")
                    defaults.setObject(self.passwordfield.text, forKey: "password2")
                    
                    defaults.setObject("on", forKey: "logout")
                    
                    
                    
                }
                
                
                
                defaults.setObject(self.usernamefield.text, forKey: "username")
                self.performSegueWithIdentifier("loginyes", sender: self)
                
            } else {
                
                
                self.checkInternet(false, completionHandler:
                    {(internet:Bool) -> Void in
                        
                        if (internet)
                        {
                            SwiftSpinner.show("Your Username Or Passoword is Incorect Please try again" ,animated: false).addTapHandler({
                                SwiftSpinner.hide()
                                 }, subtitle: "Tap To Continue")
                        }
                        else
                        {
                            SwiftSpinner.show("Contakt can't Connect Please Check Network Connection",animated: false).addTapHandler({
                                SwiftSpinner.hide()
                            })
                        }
                })
              
            }
        }
   
    }
    
    
    
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
       override func viewDidLoad() {
        
        self.usernamefield.delegate = self
        self.passwordfield.delegate = self
        
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.stringForKey("logout") == "on"
        {
            
        
        if let useranem = defaults.stringForKey("username1")
        {
            
            if let name2 = defaults.stringForKey("password2")
            {
                
                
                PFUser.logInWithUsernameInBackground(useranem, password:name2) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if user != nil {
                        
                        
                        
                        
                        
                      self.performSegueWithIdentifier("loginyes", sender: self)
                                           } else {
                        
                    }
                }
              
            }
        }
        
        }
        
        
        
        
        
        
        
        
        
        
        
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            // Do stuff with the user
            self.performSegueWithIdentifier("skip", sender: self)
        } else {
            // Show the signup or login screen
        }
        
        super.viewDidLoad()
  
        }


        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
