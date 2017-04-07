//
//  SecondViewController.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 3/29/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import UIKit
import Charts

class LiveFeedViewController: UIViewController {
    
    @IBOutlet weak var viewTitle: UINavigationItem!
    @IBOutlet weak var changeLeadButton: UIBarButtonItem! // Open PickerView Popup w/ Lead Options
    @IBOutlet weak var linePlotView: LineChartView!
    @IBOutlet weak var pickerView: UIPickerView!
    var min: Int = 0
    var max: Int = 0
    
    var dataSet: LineChartDataSet!
    static var displayedArchive: Archive?
    static var displayedLead = "Lead 1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
    }
    
    override func viewDidAppear(animated: Bool) {
        updateChartWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            entries.append(ChartDataEntry.init(value: Double(value)/440, xIndex: i))
            xValues.append("\(i)")
            if(value > max) { max = value }
            if(value < min) { min = value }
            
        }
        
        dataSet = LineChartDataSet(yVals: entries, label: "First unit test data")
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        min -= 10
        max += 10
        linePlotView.data = LineChartData(xVals: xValues, dataSet: dataSet)
        formatArchivePlot(linePlotView, data: dataSet)
    }
    
    func formatLiveFeedPlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = false
        plot.backgroundColor = NSUIColor(white: 255, alpha: 1.0)    // white background
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
        linePlotView.leftAxis.axisMinValue = Double(min)/440
        linePlotView.rightAxis.axisMinValue = Double(min)/440
        linePlotView.rightAxis.axisMaxValue = Double(max)/440
        linePlotView.leftAxis.axisMaxValue = Double(max)/440
        linePlotView.dragEnabled = true
        linePlotView.doubleTapToZoomEnabled = false
        plot.doubleTapToZoomEnabled = false
        plot.setVisibleXRangeMaximum(400)
        plot.highlightPerTapEnabled = false
        plot.highlightPerDragEnabled = true
        plot.highlightFullBarEnabled = false
        plot.legend.enabled = false
        plot.descriptionText = ""
        plot.autoScaleMinMaxEnabled = false
        plot.drawMarkers = true
        plot.maxVisibleValueCount = 3
        let xAxis = plot.xAxis
        let gridColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        let yAxisL = plot.leftAxis
        let yAxisR = plot.rightAxis
        
        yAxisL.gridColor = gridColor
        yAxisR.gridColor = gridColor
        xAxis.gridColor = gridColor
        
        xAxis.valueFormatter = AxisValueFormatter()
        
        xAxis.axisLabelModulus = 5 // 25 = Big Grid Blocks, 5 = Small Grid Blocks. 1 Small Grid block = 40ms. FIXME: not working
        
        data.setColor(NSUIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }
}

