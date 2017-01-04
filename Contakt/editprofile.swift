//
//  editprofile.swift
//  Contakt
//
//  Created by william wright  on 7/8/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class editprofile: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var name = ""
    var facebookname = ""
    
    
    @IBOutlet var linktwitebtnr: UIButton!
    
    @IBOutlet var linkfacebookbtn: UIButton!
    
  
    
    @IBOutlet var phonebox: UITextField!
    
    @IBOutlet var namebox: UITextField!
    
    @IBOutlet var emailbox: UITextField!
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func takephoto(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.Camera
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil )
        
        
        
        
        
    }
    
    
  


    
    @IBAction func preview(sender: AnyObject) {
        
        
        
        var profile = PFObject(className:"accounts")
        profile["userID"] = PFUser.currentUser()!.objectId!
        profile["name"] = self.namebox.text
        profile["phone"] = self.phonebox.text
        profile["email"] = self.emailbox.text
        profile["username"] = name
        profile["facebookname"] = facebookname
        
        
        let imagedata = UIImagePNGRepresentation(profilepic.image)
        let imagefile = PFFile(name: "image.png", data: imagedata)
        
        
        
        profile["pic"] = imagefile
        profile.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                
                
                
                
                
                
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
                
                
                
                
                
                
                defaults.setObject(profile.objectId, forKey: "ID")
                defaults.setObject(self.namebox.text, forKey: "name")
                defaults.setObject(self.phonebox.text, forKey: "phone")
                defaults.setObject(self.emailbox.text, forKey: "email")
                
                self.performSegueWithIdentifier("view", sender: self)

                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    
    
        
        
        
        
        
            }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion: nil )
        profilepic.image = image
        
        
        
    }
    
    @IBOutlet var profilepic: UIImageView!
    
    @IBAction func photo(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil )
        
        
        
        
        
        
    }
    
    
    
    @IBOutlet var top: UINavigationItem!
 
    @IBOutlet var namelable: UILabel!
    
    
    override func viewDidLoad() {
       
        
        
        
        
        
        
        
        
        
        
        
    
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("username")
        {
             top.title = (name + "'s new profile")
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
