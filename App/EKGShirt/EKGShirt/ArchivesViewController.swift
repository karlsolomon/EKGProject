//
//  ArchivesViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/30/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class ArchivesViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    // MARK: Properties
    @IBOutlet var archivesTableView: UITableView!
    
    @IBOutlet weak var emailButton: UIBarButtonItem!

    

    override func viewDidLoad() {
        //emailButton.addTarget(self, action: Selector(emailButtonPressed(self)), forControlEvents: .TouchUpInside)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Archive.ArchiveList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveCell", forIndexPath: indexPath)
        let archive = Archive.ArchiveList[indexPath.row]
        cell.textLabel?.text = archive.getDate()
        cell.detailTextLabel?.text = archive.getTime()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let email = UITableViewRowAction(style: .Normal, title: "Email", handler: {_,_ in 
            print("Email Tapped")
        })
        let delete = UITableViewRowAction(style: .Default, title: "Delete", handler: {_,_ in 
            print("Delete")
        })
        return [email, delete]
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //source.removeAtIndex(indexPath.row)
            //
            //tableView.deleteRowsAtIndexPaths([indexPath]), withAnimation: UITableViewRowAnimation.Automatic)
            //or
            //self.tableView.reloadData()
        }
    }
    
    
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: EMAIL VIEW DELEGATE
    
    @IBAction func emailButton(sender: UIBarButtonItem) {
        print("Email Button Pressed")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["ksolomon@utexas.edu"])
        mailComposerVC.setSubject("Patient Data")
        mailComposerVC.setMessageBody("Am I dying?", isHTML: false)
        if let filePath = NSBundle.mainBundle().pathForResource("samples", ofType: "csv") {
            if let fileData = NSData(contentsOfFile: filePath) {
                mailComposerVC.addAttachmentData(fileData, mimeType: "text/csv", fileName: "Sample CSV")
            }
        }
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
