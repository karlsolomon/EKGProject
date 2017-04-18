//
//  PickerViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 4/5/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//
// Allows the User to Change Leads Views in the Data Visualizer

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
        return archive?.getLeads()[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(LiveFeedViewController.displayedLead)
        LiveFeedViewController.displayedLead = (archive?.getLeads()[row])!
        print(LiveFeedViewController.displayedLead)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (archive?.getLeads().count)!
    }
    
    
}