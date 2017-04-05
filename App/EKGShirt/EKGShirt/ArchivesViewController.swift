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

    var ArchiveList = [Archive]()
    
    // MARK: Properties
    @IBOutlet var archivesTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedArchives = loadArchives() {
            ArchiveList += savedArchives
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        saveArchives()
    }
    
    override func viewDidAppear(animated: Bool) {
        ArchiveList += Archive.getNewArchiveList()
        self.archivesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: NSCODING
    
    private func saveArchives() {
       let success = NSKeyedArchiver.archiveRootObject(ArchiveList, toFile: Archive.ArchiveURL.path!)
        print("Save successful: \(success)" )
    }
    
    func addArchive(archive: Archive) {
        ArchiveList.append(archive)
        saveArchives()
    }
    
    private func loadArchives() -> [Archive]? {
        print("Loading Archives")
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Archive.ArchiveURL.path!) as? [Archive]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ArchiveList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveCell", forIndexPath: indexPath)
        let archive = ArchiveList[indexPath.row]
        cell.textLabel?.text = archive.getDate() + " " + archive.getTime()
        cell.detailTextLabel?.text = archive.getSymptomsAbbreviations()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let archive = ArchiveList[indexPath.row]
        let email = UITableViewRowAction(style: .Normal, title: "Email", handler: {_,_ in
            let mailComposeViewController = self.configuredMailComposeViewController(archive)
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            
        })
        let delete = UITableViewRowAction(style: .Default, title: "Delete", handler: {_,_ in 
            self.ArchiveList.removeAtIndex(indexPath.row)
            self.archivesTableView.reloadData()
        })
        return [email, delete]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        LiveFeedViewController.displayedArchive = ArchiveList[indexPath.row]
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LiveFeedViewController") as! LiveFeedViewController
        self.showViewController(destinationVC, sender: self)       
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            archivesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: EMAIL VIEW DELEGATE   
    func configuredMailComposeViewController(archive: Archive) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["ksolomon@utexas.edu"])
        mailComposerVC.setSubject("Patient EKG Record: " + archive.getDate() + " " + archive.getTime() )
        mailComposerVC.setMessageBody("Symptoms: \n" + archive.getSymptoms(), isHTML: false)
        if let fileData = NSData(contentsOfURL: archive.getPath()){
            mailComposerVC.addAttachmentData(fileData, mimeType: "text/csv", fileName: "Sample CSV")
        } else {
            let alert = UIAlertController(title: "File Not Found", message: "The file for this archive could not be found", preferredStyle: .Alert)
            presentViewController(alert, animated: true, completion: nil)
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
