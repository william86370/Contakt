//
//  mainprofileview.swift
//  Contakt
//
//  Created by william wright  on 8/4/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

//test import
import UIKit
import AudioToolbox
//test end
import UIKit
import Parse
import Foundation
import MessageUI
class mainprofileview: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    
    //test code 
    
    @IBAction func vibrate(sender: AnyObject) {
        
   AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        
    }
    
    //test end here
    
    
    
    
    //here i defined the names of the top of the page
    
    //call btn
    @IBOutlet var callbtn: UIButton!
    
    //message btn
    @IBOutlet var messagebtn: UIButton!
    //the text of the users name
    @IBOutlet var userdisplayname: UILabel!
    //city where the user lives 
    @IBOutlet var city: UILabel!
    //profile picture
    @IBOutlet var profilepicture: UIImageView!
    //email text
    @IBOutlet var emailbox: UILabel!
    @IBOutlet var phonebox: UILabel!
    
    @IBOutlet var biobox: UILabel!
    
    //code tp send text 
    @IBAction func text(sender: AnyObject) {
        var messageVC = MFMessageComposeViewController()
        if let currentUser = PFUser.currentUser(){
            
            let name = currentUser["Name"] as? String
            let number = currentUser["phone"] as! String
            messageVC.body = "Hey its " + name! ;
        messageVC.recipients = [number]
        }
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
    }
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.value) {
        case MessageComposeResultCancelled.value:
            println("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.value:
            println("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.value:
            println("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    
    @IBAction func makecall(sender: AnyObject) {
        if let currentUser = PFUser.currentUser(){
            
            let name = currentUser["Name"] as? String
            let number = currentUser["phone"] as! String
        var url:NSURL = NSURL(string: "tel://" + number)!
        UIApplication.sharedApplication().openURL(url)
        
        
        }
    }
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        //load the user information into the view
        if let currentUser = PFUser.currentUser(){
         
          userdisplayname.text = currentUser["Name"] as? String
          emailbox.text = currentUser["email"] as? String
           phonebox.text = currentUser["phone"] as? String
            biobox.text = currentUser["bio"] as? String
            
            
            
            let userImageFile = currentUser["profilepicture"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.profilepicture.image = image
                    }
                }
            }
            
            
                       }else{
            println("cannot connect to serevrs")
            
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
