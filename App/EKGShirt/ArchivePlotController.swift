//
//  ArchivePlotController.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 4/30/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit
import Charts

class ArchivePlotController: UIViewController{
    var min: Int = 0
    var max: Int = 0
    let gain = 1023.0/3.3  // = DAC Precision / Max Voltage
    //MARK: Properties
   // @IBOutlet weak var archivePlotView: LineChartView!
    var dataSet: LineChartDataSet!
    static var displayedArchive: Archive?
//    static var liveFeedData = Queue()
    static var displayedLead = "Lead 1" //default for first view
    static var isLiveFeed = false
    static var maxDataPoints = 400
    
    @IBOutlet weak var archivePlotView: LineChartView!
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
   //     viewTitle.title = ArchivePlotController.displayedLead
        var entries: [ChartDataEntry] = Array()
        var xValues: [String] = Array()
        min = 0
        max = 0
        var values = [Int]()
        if !ArchivePlotController.isLiveFeed {
            guard let vals = ArchivePlotController.displayedArchive?.getData(ArchivePlotController.displayedLead) else {
    //            changeLeadButton.enabled = false
                return
            }
            values = vals
        }
        else {
    //        values = ArchivePlotController.liveFeedData.getDataSource()
        }
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
        archivePlotView.data = LineChartData(xVals: xValues, dataSet: dataSet)
        formatPlot(archivePlotView, data: dataSet)
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
    }
    
    func formatPlot(plot: LineChartView, data: LineChartDataSet) {
        if ArchivePlotController.isLiveFeed {
            formatLiveFeedPlot(plot, data: data)
        } else {
            formatArchivePlot(plot, data: data)
        }
        //Shift to mV Scale
        archivePlotView.leftAxis.axisMinValue = Double(min)/gain
        archivePlotView.rightAxis.axisMinValue = Double(min)/gain
        archivePlotView.rightAxis.axisMaxValue = Double(max)/gain
        archivePlotView.leftAxis.axisMaxValue = Double(max)/gain
        
        //Interactivity
        archivePlotView.doubleTapToZoomEnabled = false
        plot.doubleTapToZoomEnabled = false
        plot.highlightPerTapEnabled = false
        plot.highlightPerDragEnabled = true
        plot.highlightFullBarEnabled = false
        
        //Marking
        plot.setVisibleXRangeMaximum(CGFloat(ArchivePlotController.maxDataPoints))   // Max for Data Visualization Rendering to be seamless
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
        //xAxis.valueFormatter = AxisValueFormatter() // Shift to Time Scale
        data.setColor(NSUIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }


}