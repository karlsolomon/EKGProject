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
import CoreData

class ArchivesViewController: UIViewController {
    static var ArchiveList = [NSManagedObject]()
    @IBOutlet var archivesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    override func viewDidAppear(animated: Bool) {
        fetch()
        archivesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetch() {
        let moc = AppDelegate().managedObjectContext
        let archiveFetch = NSFetchRequest(entityName: "Archive")
        
        do {
            ArchivesViewController.ArchiveList = try moc.executeFetchRequest(archiveFetch) as! [Archive]
        } catch {
            fatalError("Failed to get Archives: \(error)")
        }
    }
    
}


extension ArchivesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArchivesViewController.ArchiveList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArchiveCell", forIndexPath: indexPath)
        let archive = ArchivesViewController.ArchiveList[indexPath.row]
        let date = archive.valueForKeyPath("date") as? String
        let time = archive.valueForKeyPath("time") as? String
        cell.textLabel?.text = date! + " " + time!
        cell.detailTextLabel?.text = archive.valueForKeyPath("symptomsAbbreviations") as? String
        return cell
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let archive = ArchivesViewController.ArchiveList[indexPath.row]
        let email = UITableViewRowAction(style: .Normal, title: "Email", handler: {_,_ in
            let mailComposeViewController = self.configuredMailComposeViewController(archive)
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            
        })
        let delete = UITableViewRowAction(style: .Default, title: "Delete", handler: {_,_ in
            ArchivesViewController.ArchiveList.removeAtIndex(indexPath.row)
            self.archivesTableView.reloadData()
        })
        return [email, delete]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedArchive = ArchivesViewController.ArchiveList[indexPath.row] as? Archive
        
        
        LiveFeedViewController.displayedArchive = selectedArchive
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LiveFeedViewController") as! LiveFeedViewController
        self.showViewController(destinationVC, sender: self)
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            archivesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}


extension ArchivesViewController : MFMailComposeViewControllerDelegate {
    
    func configuredMailComposeViewController(archive: NSManagedObject) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["ksolomon@utexas.edu"])
        let date = archive.valueForKeyPath("archive") as? String
        let time = archive.valueForKeyPath("time") as? String
        let symptoms = archive.valueForKeyPath("symptoms") as? String
        let path = archive.valueForKeyPath("path") as? String
        
        
        
        mailComposerVC.setSubject("Patient EKG Record: " + date! + " " + time! )
        mailComposerVC.setMessageBody("Symptoms: \n" + symptoms!, isHTML: false)
        if let fileData = NSData(contentsOfFile: path!){
            mailComposerVC.addAttachmentData(fileData, mimeType: "text/csv", fileName: "EKG Recording: \(date!) \(time!)")
        } else {
            let alert = UIAlertController(title: "File Not Found", message: "The file for this archive could not be found", preferredStyle: .ActionSheet)
            let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alert.addAction(cancel)
            presentViewController(alert, animated: true, completion: nil)
        }
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
