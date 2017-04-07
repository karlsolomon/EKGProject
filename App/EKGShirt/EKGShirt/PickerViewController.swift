//
//  PickerViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 4/5/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import UIKit

class PickerViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
    }
    
    var archive = LiveFeedViewController.displayedArchive
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return archive?.valueForKey("leads")?.componentsSeparatedByString(",")[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(LiveFeedViewController.displayedLead)
        LiveFeedViewController.displayedLead = (archive?.valueForKey("leads")?.componentsSeparatedByString(",")[row])!
        print(LiveFeedViewController.displayedLead)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (archive?.valueForKey("leads")?.componentsSeparatedByString(",").count)!
    }
    
    
}