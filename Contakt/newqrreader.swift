//
//  newqrreader.swift
//  Contakt
//
//  Created by william wright  on 7/9/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//
//test import
import UIKit
import AudioToolbox
//test endimport UIKit
import AVFoundation
import Parse
class newqrreader: UIViewController , AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var lblQRCodeResult: UILabel!
    @IBOutlet weak var lblQRCodeLabel: UILabel!
    
    var objCaptureSession:AVCaptureSession?
    var objCaptureVideoPreviewLayer:AVCaptureVideoPreviewLayer?
    var vwQRCode:UIView?
    var code = ""
     var test = 0
    
    
    @IBAction func taped(sender: AnyObject) {
        println("tapped")
        
        
    }
    

    
    func configureVideoCapture()
    {
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(objCaptureDevice, error: &error)
        if (error != nil) {
            var alertView:UIAlertView = UIAlertView(title: "Device Error", message: "Device not Supported for this Application" , delegate: nil, cancelButtonTitle: "Ok Done")
                alertView.show()
            return
        }
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    func addVideoPreviewLayer()
    {
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer)
        objCaptureSession?.startRunning()
        self.view.bringSubviewToFront(lblQRCodeResult)
        self.view.bringSubviewToFront(lblQRCodeLabel)
                }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.greenColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if test == 2 {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        }
        if test == 1 {
            var users = PFQuery(className: "_User")
            users.whereKey("objectId", equalTo: code)
            users.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if let objects = objects {
                    for object in objects {
                        var newuser = object["username"] as! String
                        println(newuser)
                        
                        
                        
                        let alertController = UIAlertController(title: "you have added", message:
                            newuser, preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        
                        
                        self.test = 2
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                        
                    }
                }
            })
        }
        
        
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
            lblQRCodeResult.text = "No Contakt code detected"
            test = 0
            return
        }
        if test == 0 {
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                var usernameadd = objMetadataMachineReadableCodeObject.stringValue
                println("code descoved")
                
                if count(usernameadd) == 10 {
                    
                    
                     test = 1
                    println("Contakt code read")
                    let defaults = NSUserDefaults.standardUserDefaults()
                    self.code = objMetadataMachineReadableCodeObject.stringValue
                
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                
                                //self.performSegueWithIdentifier("exit", sender: self)
                
                /*let alertController = UIAlertController(title: "you have added", message:
                objMetadataMachineReadableCodeObject.stringValue, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                self.performSegueWithIdentifier("exit", sender: self)
                
                */
                
               
                
                
                
                
                
                
                lblQRCodeResult.text = objMetadataMachineReadableCodeObject.stringValue
            
            
            
            
            
            
                }
            
            
            
            }
        }
    }
   
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        configureVideoCapture()
        addVideoPreviewLayer()
        initializeQRView()
        
        var users = PFQuery(className: "_User")
        users.whereKey("objectId", equalTo: code)
        users.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    var newuser = object["username"] as! String
                    println(newuser)
                    
                    
                    
                    
                    let alertController = UIAlertController(title: "you have added", message:
                        newuser, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    self.performSegueWithIdentifier("exit", sender: self)
                    
                }
            }
        })
        
        
       

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
