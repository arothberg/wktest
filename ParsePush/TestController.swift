//
//  ViewController.swift
//  ParsePush
//
//  Created by Tommy Fannon on 9/13/15.
//  Copyright (c) 2015 Crazy8Dev. All rights reserved.
//

import UIKit

class TestController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        txtIPAddress.delegate = self
        txtIPAddress.text = Services.ipAddress
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var lblLoginResult: UILabel!
    @IBAction func loginPressed(sender: AnyObject) {
        Services.login("joe.contact", token: "foobar") { result in
            self.lblLoginResult.text = result
        }
    }
    
    
    @IBOutlet weak var lblCount: UILabel!
    @IBAction func countPressed(sender: AnyObject) {
        Services.getUnreadCount() { result in
            self.lblCount.text = String(result)
        }
    }
    
    @IBAction func markReadPressed(sender: AnyObject) {
        Services.markRead([2,3]) { result in
        }
    }
    
    
    @IBOutlet weak var txtIPAddress: UITextField!
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        Services.ipAddress = textField.text!
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(textField.text!, forKey: "ipAddress")
        defaults.synchronize()
        textField.resignFirstResponder();
        return true;
    }
    
    
    @IBAction func getNotificationsPressed(sender: AnyObject) {
        self.lblNotifications.text = ""
        Services.getUnreadNotifications() { result in
            for x in result! {
                print("\(x.title!): \(x.description!)")
            }
            self.lblNotifications.text = "\(result!.count) received"
        }
    }
    @IBOutlet weak var lblNotifications: UILabel!
    
    
    @IBOutlet weak var txtAssessment: UITextField!
    @IBAction func assessmentPressed(sender: AnyObject) {
        self.txtAssessment.text = ""
        Services.GetPOCAssessmentId { id in
            self.txtAssessment.text = String(id!)
        }
    }
    
    @IBOutlet weak var lblProcedures: UILabel!
    @IBAction func proceduresPressed(sender: AnyObject) {
        self.lblProcedures.text = ""
        Services.GetProcedures { result in
            self.lblProcedures.text = String(result!.count)
        }
    }
    
}

