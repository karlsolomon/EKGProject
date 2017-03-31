//
//  SymptomsLegendController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/31/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit

class SymptomsLegendController: UITableViewController {
    
    let symptomsLegend = Symptoms.instance.getSymptomsLegend()
    let cellIdentifier = "legendCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded legend")
        tableView.allowsSelection = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomsLegend.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = symptomsLegend[indexPath.row]
        return cell
    }
}
