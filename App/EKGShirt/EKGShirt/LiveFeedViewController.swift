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
    @IBOutlet weak var linePlotView: LineChartView!
    @IBOutlet weak var changeLeadButton: UIBarButtonItem! // Open PickerView Popup w/ Lead Options
    
    var dataSet: LineChartDataSet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartWithData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData() {
        let values: [Double] = [8, 104, 81, 93, 52, 44, 97, 101, 75, 28,
                                76, 25, 20, 13, 52, 44, 57, 23, 45, 91,
                                99, 14, 84, 48, 40, 71, 106, 41, 45, 61]
        
        var entries: [ChartDataEntry] = Array()
        var xValues: [String] = Array()
        
        for (i, value) in values.enumerate()
        {
            entries.append(ChartDataEntry.init(value: value, xIndex: i))
            xValues.append("\(i)")
        }
        
        dataSet = LineChartDataSet(yVals: entries, label: "First unit test data")
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        linePlotView.leftAxis.axisMinValue = 0.0
        linePlotView.rightAxis.axisMinValue = 0.0
        linePlotView.data = LineChartData(xVals: xValues, dataSet: dataSet)
        linePlotView.dragEnabled = true
        linePlotView.doubleTapToZoomEnabled = false
        formatArchivePlot(linePlotView, data: dataSet)
    }
    
    func formatLiveFeedPlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = false
        plot.backgroundColor = NSUIColor(white: 255, alpha: 1.0)    // white background
        plot.noDataText = "Waiting for EKG Data"
        plot.autoScaleMinMaxEnabled = true
        formatPlot(plot, data: data)
    }
    
    func formatArchivePlot(plot: LineChartView, data: LineChartDataSet) {
        plot.dragEnabled = true
        plot.dragDecelerationEnabled = true
        plot.dragDecelerationFrictionCoef = 0.75
        plot.autoScaleMinMaxEnabled = true
        plot.keepPositionOnRotation = true
        formatPlot(plot, data: data)
    }
    
    func formatPlot(plot: LineChartView, data: LineChartDataSet) {
        plot.doubleTapToZoomEnabled = false
        plot.setVisibleXRangeMaximum(10.0)  // make 300 to match 2.4s 125Hz readout
        plot.highlightPerTapEnabled = false
        plot.highlightPerDragEnabled = true
        plot.highlightFullBarEnabled = false
        plot.legend.enabled = false
        plot.descriptionText = ""
        let xAxis = plot.xAxis
        let gridColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        let yAxisL = plot.leftAxis
        let yAxisR = plot.rightAxis
        
        yAxisL.gridColor = gridColor
        yAxisR.gridColor = gridColor
        xAxis.gridColor = gridColor
        
        xAxis.axisLabelModulus = 5 // 25 = Big Grid Blocks, 5 = Small Grid Blocks. 1 Small Grid block = 40ms. FIXME: not working
        
        data.setColor(NSUIColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }
    
 

}

