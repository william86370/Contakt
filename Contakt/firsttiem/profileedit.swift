//
//  profileedit.swift
//  Contakt
//
//  Created by william wright  on 8/4/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse

class profileedit: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//name textbox
    @IBOutlet var namebox: UITextField!
    //city btn
    @IBOutlet var citybtn: UIButton!
    //pfp change btn
    @IBOutlet var picchange: UIButton!
    //the picture itself 
    @IBOutlet var picture: UIImageView!
    //the bio
    @IBOutlet var thingsaboutme: UITextField!
    //import from contact 
    @IBOutlet var importbtn: UIButton!
    //email text
    @IBOutlet var emailbox: UITextField!
    //phone number text
    @IBOutlet var phonebox: UITextField!
    //gender switch
    @IBOutlet var gender: UISegmentedControl!
    //the active intacater view
    @IBOutlet var active: UIActivityIndicatorView!
    //save button
    @IBOutlet var savebtn: UIButton!
    
    
    
    
    
    
    
    
   
    
        
    
    
    
    
    
    
    
    
    @IBAction func pickphoto(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        picture.image = image
    }
   
    
    @IBAction func next(sender: AnyObject) {
        savebtn.hidden = true
        self.active.startAnimating()
        
        if let currentUser = PFUser.currentUser(){
            if currentUser["email"] as? String != ""{
            currentUser["email"] = emailbox.text
                currentUser.saveInBackground()
                
                SwiftSpinner.show("Updateing Your Email")
            }
            if currentUser["Name"] as? String != ""{
            currentUser["Name"] = namebox.text
                currentUser.saveInBackground()
                SwiftSpinner.show("Updateing Your Username")
            }
            if currentUser["phone"] as? String != ""{
            currentUser["phone"] = phonebox.text
                currentUser.saveInBackground()
                SwiftSpinner.show("Updateing Your Phone")
        }
            if currentUser["bio"] as? String != ""{
            currentUser["bio"] = thingsaboutme.text
                currentUser.saveInBackground()
                SwiftSpinner.show("Updateing Your Bio")
            }
            
            let imagedata = UIImageJPEGRepresentation(picture.image,0.5)
            let imagefile = PFFile(name: currentUser["Name"] as! String + ".jpg", data: imagedata)
            currentUser["profilepicture"] = imagefile
            SwiftSpinner.show("Updateing Your Profile Picture")
        
            //set other fields the same way....
            currentUser.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    SwiftSpinner.hide()
                    self.active.stopAnimating()
                     self.performSegueWithIdentifier("profile", sender: self)
                    
                    
                    
                    
                    
                    
                    
                    
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        
        
            
        
        
        
        }
        //ends here
    }
    
    override func viewDidLoad() {
        println("1")
        if let currentUser = PFUser.currentUser(){
            if currentUser["email"] as? String != "" {
                 emailbox.text = currentUser["email"] as? String
            }
            println("2")
            if currentUser["Name"] as? String != ""{
                namebox.text = currentUser["Name"] as? String
            }
            println("3")
            if currentUser["phone"] as? String != ""{
                phonebox.text = currentUser["phone"] as? String
            }
            println("4")
            if currentUser["bio"] as? String != ""{
                 thingsaboutme.text = currentUser["bio"] as? String
            }
            println("5")
       
            if currentUser["profilepicture"] as? PFFile != nil {
                
            
        let userImageFile = currentUser["profilepicture"] as! PFFile
            userImageFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                       let image = UIImage(data:imageData)
                        self.picture.image = image
                       println("7")
                    }
                }
           }
            
            
            
            
            
            
            
        }else{
            println("cannot connect to serevrs")
       
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
extension UIImage {
    var highestQualityJPEGNSData:NSData { return UIImageJPEGRepresentation(self, 1.0) }
    var highQualityJPEGNSData:NSData    { return UIImageJPEGRepresentation(self, 0.75)}
    var mediumQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.5) }
    var lowQualityJPEGNSData:NSData     { return UIImageJPEGRepresentation(self, 0.25)}
    var lowestQualityJPEGNSData:NSData  { return UIImageJPEGRepresentation(self, 0.0) }
}