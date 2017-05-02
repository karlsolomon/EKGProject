//
//  SecondViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/29/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit
import Charts   //External Chart Library

class LiveFeedViewController: UIViewController {
    
    @IBOutlet weak var viewTitle: UINavigationItem!
    @IBOutlet weak var changeLeadButton: UIBarButtonItem! // Open PickerView Popup w/ Lead Options
    @IBOutlet weak var linePlotView: LineChartView!
    @IBOutlet weak var pickerView: UIPickerView!
    var min: Int = 0
    var max: Int = 0
    let lead1Gain = 1023.0/3.3  // = DAC Precision / Empirical Voltage Range
    let lead2Gain = 1023.0/3.3
    let lead3Gain = 1023.0/3.3
    
    var dataSet: LineChartDataSet!
    static var displayedArchive: Archive?
    static var liveFeedData = Queue()
    static var displayedLead = "Lead 1" //default for first view
    static var isLiveFeed = false
    static var maxDataPoints = 400
    let back = UIButton(frame: CGRect(x: 20.0, y: 20.0, width: 100.0, height: 60.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
        back.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
    }
    
    @objc private func goBack(){
        self.showViewController((self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")) as! TabBarController, sender: self)
        self.tabBarController?.selectedIndex = 0
    }
    override func viewDidAppear(animated: Bool) {
        updateChartWithData()
        self.view.addSubview(back)
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        updateChartWithData() // reinitializes scaling
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateChartWithData() {
        viewTitle.title = LiveFeedViewController.displayedLead
        var entries: [ChartDataEntry] = Array()
        var xValues: [String] = Array()
        min = 0
        max = 0
        var values = [Int]()
        if !LiveFeedViewController.isLiveFeed {
            guard let vals = LiveFeedViewController.displayedArchive?.getData(LiveFeedViewController.displayedLead) else {
                changeLeadButton.enabled = false
                return
            }
            values = vals
        }
        else {
            values = LiveFeedViewController.liveFeedData.getDataSource()
        }
        for (i, value) in values.enumerate()
        {
            entries.append(ChartDataEntry.init(value: Double(value)/getActiveGain(), xIndex: i))
            xValues.append("\(i)")
            if(value > max) { max = value }
            if(value < min) { min = value }
            
        }
        dataSet = LineChartDataSet(yVals: entries, label: "First unit test data")
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        
        min -= 10   // 10 dip margin in Y
        max += 10
        linePlotView.data = LineChartData(xVals: xValues, dataSet: dataSet)
        formatPlot(linePlotView, data: dataSet)
    }
    
    func formatLiveFeedPlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = false
        plot.noDataText = "Waiting for EKG Data"
    }
    
    func formatArchivePlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = true
        plot.dragDecelerationEnabled = true
        plot.dragDecelerationFrictionCoef = 0.95
        plot.keepPositionOnRotation = true
        plot.noDataText = "Archive Not Found"
    }
    
    private func getActiveGain() -> Double {
        if(LiveFeedViewController.displayedLead == "Lead 1") {
            return self.lead1Gain
        } else if (LiveFeedViewController.displayedLead == "Lead 2"){
            return self.lead2Gain
        } else if (LiveFeedViewController.displayedLead == "Lead 3") {
            return self.lead3Gain
        } else {
            return 0.0
        }
    }
    
    func formatPlot(plot: LineChartView, data: LineChartDataSet) {
        if LiveFeedViewController.isLiveFeed {
            formatLiveFeedPlot(plot, data: data)
        } else {
            formatArchivePlot(plot, data: data)
        }

        //Interactivity
        plot.doubleTapToZoomEnabled = false
        plot.highlightPerTapEnabled = false
        plot.highlightPerDragEnabled = true
        plot.highlightFullBarEnabled = false
        plot.rightAxis.enabled = false
        
        //Marking
        plot.setVisibleXRangeMaximum(CGFloat(LiveFeedViewController.maxDataPoints))   // Max for Data Visualization Rendering to be seamless
        plot.legend.enabled = false
        plot.descriptionText = ""   //silences description
        plot.autoScaleMinMaxEnabled = true
        plot.drawMarkers = true
        
        let xAxis = plot.xAxis
        let gridColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        let yAxisL = plot.leftAxis
        
        yAxisL.gridColor = gridColor
        xAxis.gridColor = gridColor
        xAxis.valueFormatter = AxisValueFormatter() // Shift to Time Scale
        data.setColor(NSUIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }
}

