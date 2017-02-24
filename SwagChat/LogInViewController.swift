//
//  ViewController.swift
//  SwagChat
//
//  Created by Savannah McCoy on 6/21/16.
//  Copyright © 2016 Savannah McCoy. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logInAction(sender: UIButton) {
        
        let username = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                
                
                let alertController = UIAlertController(title: "Error", message: "Log In Unsuccessful", preferredStyle: .Alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
                
                
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("Logged In!!")
                // display view controller that needs to shown after successful login
                
                self.performSegueWithIdentifier("loginSegue", sender: nil)
                
                
            }
        }
        
        
        
    }
    @IBAction func signInAction(sender: UIButton) {
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = emailField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                
                let alertController = UIAlertController(title: "Error", message: "Registration Unsuccessful", preferredStyle: .Alert)
                // create a cancel action
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                alertController.addAction(cancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
                
                
                
                print("User login failed.")
                print(error.localizedDescription)
            
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }
        }
        
        
        
    }

}

