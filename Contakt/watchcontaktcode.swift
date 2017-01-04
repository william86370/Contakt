//
//  watchcontaktcode.swift
//  Contakt
//
//  Created by william wright  on 8/23/15.
//  Copyright (c) 2015 A.R.C software and engineering. All rights reserved.
//

import WatchKit
import Foundation
import Parse



class watchcontaktcode: WKInterfaceController {

    
    @IBOutlet var imageview: WKInterfaceImage!
    
    
    
    
    
    
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
    
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        imageview.setImage(generateQRImage("hello", withSizeRate: 5))        // Configure interface objects here.
    }

    override func willActivate() {
        imageview.setImage(generateQRImage("hello", withSizeRate: 5))
        
        
        
        
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        
        super.didDeactivate()
    }

}
