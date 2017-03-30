/*
Symptoms Table View Controller
*/

// Handle Multiple Touch
var currentSymptoms = [String]()

override func viewDidLoad() {
    super.viewDidLoad()
    currentSymptoms = [String]()
    self.tableView.allowsMultipleSelection = true

    @IBAction func recordButtonClicked(sender: UIButton) {
		if(symptoms.dangerousSymptoms(symptoms: currentSymptoms)) {
			var uiAlert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
			self.presentViewController(uiAlert, animated: true, completion: nil)

			uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
				if let url = NSURL(string: "tel://\(2817452091)") where UIApplication.sharedApplication().canOpenURL(url) {
					UIApplication.sharedApplication().openURL(url)
				}
			}))

			uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
			}))
			present(alert, animated: true, completion: nil)
		}
		// disable recordButton for 2.5 minutes
		sender.enabled = false
		sender.userInteractionEnabled = false
		NSTimer.scheduledTimerWithTimeInterval 150, target: self, selector: #selector(ViewController.enableButton), userInfo: nil, repeats: true)
		print(currentSymptoms) // later send to Archives Class 
	}
}

func enableButton() {
    self.buttonTest.enabled = true
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    [...]
    cell.accessoryType = cell.isSelected ? .checkmark : .none
    cell.selectionStyle = .none // to prevent cells from being "highlighted"
    [...]
}
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    currentSymptoms.append(indexPath.row)
}

override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
    currentSymptoms.remove(indexPath.row)
}



// Populate Table Elements
//TODO


