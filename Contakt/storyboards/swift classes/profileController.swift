//
//  profileController.swift
//  Contakt
//
//  Created by william wright  on 8/28/15.
//  Copyright (c) 2015 A.R.C software and engineering. All rights reserved.
//

import UIKit

class profileController: UIViewController {
    
    //asign all of the lablesand other things
    
    //email lable
    @IBOutlet var emailbox: UILabel!
    //phone lable
    @IBOutlet var phonebox: UILabel!
    //bio label
    @IBOutlet var biobox: UILabel!
    //picture 
    @IBOutlet var profilepicture: UIImageView!
    //phone btn
    @IBOutlet var phonebutton: UIButton!
    //text btn
    @IBOutlet var textbutton: UIButton!
    //profile name 
    @IBOutlet var profilename: UILabel!
    //inport the code scaned
    var profilecode = "NT7QOsaBkr"
    
    
    
    
    
    
    
    

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
