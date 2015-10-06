//
//  NewMessageViewController.swift
//  Mailbox
//
//  Created by Lin Wang on 10/5/15.
//  Copyright © 2015 Lin Wang. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        toTextField.becomeFirstResponder()

    }

    @IBAction func cancelButtonOn(sender: AnyObject) {
        
        UIView.animateWithDuration(0.3, delay: 0.4, options: [], animations: { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            }, completion: nil)
        }
    }

