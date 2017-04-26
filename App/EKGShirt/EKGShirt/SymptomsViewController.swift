//
//  FirstViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/29/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.

import UIKit

class SymptomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
// MARK: Properties
    @IBOutlet weak var definitions: UIBarButtonItem!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sampleCell: UIView!
    
    let contents = Symptoms.instance.getAllSymptoms()   // Symtpoms Table Data Source
	var selectedSymptoms = [String]()
    let cellIdentifier = "symptomsCell"
	var symptomsSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.setTitle("Record EKG", forState: UIControlState.Normal)
        tableView.delegate = self
        tableView.dataSource = self
        allowSelection(false)
        let tapRecord = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapRecord.numberOfTapsRequired = 1
        recordButton.addGestureRecognizer(tapRecord)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
/*  If User is likely having cardiac emergency, prompts user to call 911.
    Toggles Button between "Record EKG" & "Submit Symtpoms"
    Disables Button while EKG Data is being captured to avoid duplicate data
     */
    func tap(sender: UITapGestureRecognizer) {
        if(symptomsSelected) {
            if(selectedSymptoms.count == 0) {
                //must select at least one symptom
                let alert = UIAlertController(title: "Invalid Symptoms", message: "Select at least one symptom", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { action in
                }))
                presentViewController(alert, animated: true, completion: nil)
                return
            }
            else if(!Symptoms.instance.validSymptoms(selectedSymptoms)) {
                let alert = UIAlertController(title: "Invalid Symptoms", message: "Cannot select \"None\" and other symptoms", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { action in
                }))
                presentViewController(alert, animated: true, completion: nil)
                return
            }            
            
            else if(Symptoms.instance.dangerousSymptoms(selectedSymptoms)) {
                let alert = UIAlertController(title: "Cardiac Emergency", message: "You have 3 or more symptoms that are symptoms of cardiac emergencies. Would you like to call Emergency Medical Services?", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Call 911", style: .Default, handler: { action in
                    if let url = NSURL(string: "tel://2817452091") where UIApplication.sharedApplication().canOpenURL(url) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            }))
            presentViewController(alert, animated: true, completion: nil)
            }
            NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(self.enableButton), userInfo: nil, repeats: false)  //TODO: IN FINAL RELEASE CHANGE TIME INTERVAL TO 150 (2.5 MINUTES)
            recordButton.setTitle("Record EKG", forState: UIControlState.Normal)
            recordButton.enabled = false
            allowSelection(false)
            sendSymptoms()
            resetTable()
        } else {
            recordButton.setTitle("Submit Symptoms", forState: UIControlState.Normal)//titleLabel = "Submit Symptoms"
            symptomsSelected = true
            allowSelection(true)
        }
    }
    
    func allowSelection(selection: Bool) {
        if(selection) {
            tableView.allowsSelection = true
            tableView.allowsMultipleSelection = true
        }
        else {
            tableView.allowsMultipleSelection = false
            tableView.allowsSelection = false
        }
    }
    
    func enableButton() {
        self.recordButton.enabled = true
    }
    
    //Refreshes Symptoms Table between events to deselect all symptoms
    func resetTable() {
        var symptom = ""
        var symptomIndex = 0
        for i in (0..<selectedSymptoms.count).reverse() {
            symptom = selectedSymptoms[i]
            symptomIndex = selectedSymptoms.indexOf(symptom)!
            selectedSymptoms.removeAtIndex(symptomIndex)
        }
        tableView.reloadData()
        symptomsSelected = false
    }
    

//MARK: UI TABLE VIEW DATA SOURCE
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
	    cell.textLabel?.text = contents[indexPath.row]	 
	    return cell
	}

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    
//MARK: UI TABLE VIEW DELEGATE
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSymptoms.append(contents[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSymptoms.removeAtIndex(selectedSymptoms.indexOf(contents[indexPath.row])!)
    }
    
    
//MARK: SEND SYMPTOMS
    func sendSymptoms() {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM_dd_yy_hh_mm"
        let dateString = formatter.stringFromDate(date)
        let client = SocketClient(fileName: dateString)       //TODO: REMOVE COMMENT WHEN RPI SOCKET IS VERIFIED, Update URLForResource string to be the datetime string
        
        if let filePath = NSBundle.mainBundle().URLForResource(dateString, withExtension: "csv"){
            let archive = Archive(date: date, path: filePath, symptoms: selectedSymptoms)
            ArchivesViewController().addArchive(archive)
        } else {
            let noFileFound = UIAlertController(title: "FILE NOT FOUND", message: "File at specified location not found", preferredStyle: .Alert)
            let cancel = UIAlertAction(title: "Cancel", style: .Default, handler: { action in
            })
            noFileFound.addAction(cancel)
            presentViewController(noFileFound, animated: true, completion: nil)
        }
    }


}