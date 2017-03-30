//
//  FirstViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/29/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit

class SymptomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	let contents = ["Symptom 1", "Symptom 2"]
	var selectedSymptoms = [String]()
	let textCellIdentifier = "TextCell"
	let symptomsSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.titleLabel = "Record"
        tableView.delegate = self	// must name tableView "symptomsView" in storyboard
        tableView.dataSource = self

        tableView.userInteractionEnabled = false
        tableView.allowsMultipleSelection = true
    }


	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	    let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)	 
	    cell.textLabel?.text = contents[indexPath.row]	 
	    return cell
	}


	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
	    return contents.count
	}

	@IBAction func recordButton(sender: UIButton) {
		if(symptomsSelected) {
			if(symptoms.dangerousSymptoms(symptoms: currentSymptoms)) {
				var alert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
					if let url = NSURL(string: "tel://\(2817452091)") where UIApplication.sharedApplication().canOpenURL(url) {
						UIApplication.sharedApplication().openURL(url)
					}
				}))
				alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
				}))
				presentViewController(alert, animated: true, completion: nil)
				//present(alert, animated: true, completion: nil)
			}
			NSTimer.scheduledTimerWithTimeInterval 150, target: recordButton, selector: #selector(ViewController.enableButton), userInfo: nil, repeats: true)
			performSegueWithIdentifier("SendSymptoms", sender: sender)

		} else {
			recordButton.titleLabel = "Submit Symptoms"
			symptomsSelected = true
			tableView.userInteractionEnabled = true
		}
	}


	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {	 
	    selectedSymptoms.append(contents[indexPath.row])
	}

	func tableView(tableView: UITableView, deselectRowAtIndexPath indexPath: NSIndexPath) {	 
	    selectedSymptoms.remove(contents[indexPath.row])
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

