//
//  FirstViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/29/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
// Tags: Definitions Button = 0, TableView = 1, RecordButton = 2

import UIKit

class SymptomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var definitions: UIBarButtonItem!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sampleCell: UIView!
    
	var contents = ["Symptom 1", "Symptom 2", "Symptom 3"]
	var selectedSymptoms = [String]()
    let cellIdentifier = "symptomsCell"
	var symptomsSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.setTitle("Record EKG", forState: UIControlState.Normal)
        tableView.delegate = self	// must name tableView "symptomsView" in storyboard
        tableView.dataSource = self
        tableView.userInteractionEnabled = false
        tableView.allowsMultipleSelection = true
        
        let tapRecord = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tapRecord.numberOfTapsRequired = 1
        recordButton.addGestureRecognizer(tapRecord)
    }
    
//Custom Button Handling
    func tap(sender: UITapGestureRecognizer) {
        print("Record Pressed")
        if(symptomsSelected) {
            //if(symptoms.dangerousSymptoms(symptoms: currentSymptoms)) {
            let alert = UIAlertController(title: "Cardiac Emergency", message: "You have 3 or more symptoms that are symptoms of cardiac emergencies. Would you like to call Emergency Medical Services?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Call 911", style: .Default, handler: { action in
                if let url = NSURL(string: "tel://\(2817452091)") where UIApplication.sharedApplication().canOpenURL(url) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            }))
            presentViewController(alert, animated: true, completion: nil)
            NSTimer.scheduledTimerWithTimeInterval(150, target: self, selector: #selector(self.enableButton), userInfo: nil, repeats: false)
            recordButton.setTitle("Record EKG", forState: UIControlState.Normal)
            recordButton.enabled = false
            print("Selected the following: \(selectedSymptoms)")
            //TODO: Send Symptoms
            
        } else {
            recordButton.setTitle("Submit Symptoms", forState: UIControlState.Normal)//titleLabel = "Submit Symptoms"
            symptomsSelected = true
            tableView.userInteractionEnabled = true
        }
    }
    
    func enableButton() {
        print("timer Ended")
        self.recordButton.enabled = true
    }
    

//UI TABLE VIEW DATA SOURCE
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
	    cell.textLabel?.text = contents[indexPath.row]	 
	    return cell
	}


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    
    
//UI TABLE VIEW DELEGATE
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSymptoms.append(contents[indexPath.row])
        print("added \(contents[indexPath.row])")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSymptoms.removeAtIndex(selectedSymptoms.indexOf(contents[indexPath.row])!)
        print("removed \(contents[indexPath.row])")
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}