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
        self.view.addSubview(tableView)
        self.view.addSubview(recordButton)
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
    
    func tableView(tableView: UITableView, deselectRowAtIndexPath indexPath: NSIndexPath) {
        selectedSymptoms.removeAtIndex(selectedSymptoms.indexOf(contents[indexPath.row])!)
        print("removed \(contents[indexPath.row])")
    }

	@IBAction func recordButton(sender: UIButton) {
    
		if(symptomsSelected) {
			//if(symptoms.dangerousSymptoms(symptoms: currentSymptoms)) {
				let alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
					if let url = NSURL(string: "tel://\(2817452091)") where UIApplication.sharedApplication().canOpenURL(url) {
						UIApplication.sharedApplication().openURL(url)
					}
				}))
				alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
				}))
				presentViewController(alert, animated: true, completion: nil)
				//present(alert, animated: true, completion: nil)
			//}
            //NSTimer.scheduledTimerWithTimeInterval(150, target: recordButton, selector: #selector(SymptomsViewController.enableButton), userInfo: nil, repeats: false)
			//performSegueWithIdentifier("SendSymptoms", sender: sender)

		} else {
			recordButton.setTitle("Submit Symptoms", forState: UIControlState.Normal)//titleLabel = "Submit Symptoms"
			symptomsSelected = true
			tableView.userInteractionEnabled = true
		}
	}
    
    func enableButton() {
        recordButton.enabled = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}