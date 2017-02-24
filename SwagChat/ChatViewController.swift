//
//  ChatViewController.swift
//  SwagChat
//
//  Created by Savannah McCoy on 6/21/16.
//  Copyright © 2016 Savannah McCoy. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messageArray : [PFObject] = []
    var userArray : [PFObject] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.dataSource = self
        chatTableView.delegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ChatViewController.refreshMessages), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messageArray.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as!  MessageViewCell
        let messageText = self.messageArray[indexPath.row].objectForKey("text") as! String
         let userText = self.messageArray[indexPath.row].objectForKey("user")!.objectForKey("username") as! String

        
        cell.messageLabel.text = messageText
        cell.usernameLabel.text = userText
        
        print ("row\(indexPath.row)")
        return cell
    }

    
    @IBAction func didSubmit(sender: AnyObject) {
        let message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = messageField.text
    
        message["user"] = PFUser.currentUser()
    
        
       
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("Message saved")
            } else {
                // There was a problem, check error.description
                print("Message not saved")
            }
        }

    }
    
    func refreshMessages() {
        
        let query = PFQuery(className:"Message_fbuJuly2016")
        
        query.orderByDescending("createdAt")
        
        
        query.includeKey("user")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                
                self.messageArray = objects!
                
                if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
        chatTableView.reloadData()
        
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
