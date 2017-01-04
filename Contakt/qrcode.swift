//
//  qrcode.swift
//  Contakt
//
//  Created by william wright  on 7/7/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import AVFoundation
import Parse



class qrcode: UIViewController {
    
    
    
    
    
    //share btn
    @IBAction func share(sender: AnyObject) {
        
        
    }
    
    
    @IBOutlet var image: UIImageView!
    var ID  = ""
    
    
    
    
        
        
    @IBAction func signout(sender: AnyObject) {
        
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        defaults.setObject("", forKey: "logout")

        
        self.performSegueWithIdentifier("logout", sender: self)

        
        
    }
        
    
    
    
    
    
    
    func generateQRImage(stringQR:NSString, withSizeRate rate:CGFloat) -> UIImage
    {
        var filter:CIFilter = CIFilter(name:"CIQRCodeGenerator")
        filter.setDefaults()
        
        var data:NSData = stringQR.dataUsingEncoding(NSUTF8StringEncoding)!
        filter.setValue(data, forKey: "inputMessage")
        
        var outputImg:CIImage = filter.outputImage
        
        var context:CIContext = CIContext(options: nil)
        var cgimg:CGImageRef = context.createCGImage(outputImg, fromRect: outputImg.extent())
        
        var img:UIImage = UIImage(CGImage: cgimg, scale: 1.0, orientation: UIImageOrientation.Up)!
        
        var width  = img.size.width * rate
        var height = img.size.height * rate
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        var cgContxt:CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(cgContxt, kCGInterpolationNone)
        img.drawInRect(CGRectMake(0, 0, width, height))
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("ID")
        {
            var ID  = name
        }
        
        image.image = generateQRImage(PFUser.currentUser()!.objectId!, withSizeRate: 80)

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
