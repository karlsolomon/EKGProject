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
    let gain = 1023/5  // = DAC Precision / Max Voltage
    
    var dataSet: LineChartDataSet!
    static var displayedArchive: Archive?
    static var displayedLead = "Lead 1" //default for first view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    
    override func viewDidAppear(animated: Bool) {
        updateChartWithData()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        updateChartWithData() // reinitializes scaling
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateChartWithData() {
        min = 0
        max = 0
        viewTitle.title = LiveFeedViewController.displayedLead
        guard let values = LiveFeedViewController.displayedArchive?.getData(LiveFeedViewController.displayedLead) else {
            changeLeadButton.enabled = false
            return
        }
        
        var entries: [ChartDataEntry] = Array()
        var xValues: [String] = Array()
        
        for (i, value) in values.enumerate()
        {
            entries.append(ChartDataEntry.init(value: Double(value)/gain, xIndex: i))
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
        formatArchivePlot(linePlotView, data: dataSet)
    }
    
    func formatLiveFeedPlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = false
        plot.noDataText = "Waiting for EKG Data"
        formatPlot(plot, data: data)
    }
    
    func formatArchivePlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = true
        plot.dragDecelerationEnabled = true
        plot.dragDecelerationFrictionCoef = 0.8
        plot.keepPositionOnRotation = true
        formatPlot(plot, data: data)
    }
    
    func formatPlot(plot: LineChartView, data: LineChartDataSet) {
        //Shift to mV Scale
        linePlotView.leftAxis.axisMinValue = Double(min)/gain
        linePlotView.rightAxis.axisMinValue = Double(min)/gain
        linePlotView.rightAxis.axisMaxValue = Double(max)/gain
        linePlotView.leftAxis.axisMaxValue = Double(max)/gain
        
        //Interactivity
        linePlotView.dragEnabled = true
        linePlotView.doubleTapToZoomEnabled = false
        plot.doubleTapToZoomEnabled = false
        plot.highlightPerTapEnabled = false
        plot.highlightPerDragEnabled = true
        plot.highlightFullBarEnabled = false
        
        //Marking
        plot.setVisibleXRangeMaximum(400)   // Max for Data Visualization Rendering to be seamless
        plot.legend.enabled = false
        plot.descriptionText = ""   //silences description
        plot.autoScaleMinMaxEnabled = false
        plot.drawMarkers = true
        plot.maxVisibleValueCount = 3 // most XLabels Visible w/o cluttering screen
        
        let xAxis = plot.xAxis
        let gridColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        let yAxisL = plot.leftAxis
        let yAxisR = plot.rightAxis
        
        yAxisL.gridColor = gridColor
        yAxisR.gridColor = gridColor
        xAxis.gridColor = gridColor
        xAxis.valueFormatter = AxisValueFormatter() // Shift to Time Scale
        data.setColor(NSUIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }
}

