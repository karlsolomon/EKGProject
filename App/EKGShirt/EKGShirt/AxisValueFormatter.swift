//
//  XAxisValueFormatter.swift
//  EKGShirt
//
//  Created by Solomon, Karl on 4/7/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
import Charts

class AxisValueFormatter : ChartXAxisValueFormatter{
    private let sampleTiming = 8 //mS
    @objc func stringForXValue(index: Int, original: String, viewPortHandler: ChartViewPortHandler) -> String {
        var xAxisValue = "\(sampleTiming*index/1000 ).\(sampleTiming*index%1000)"
        if (xAxisValue.characters.count > 4) {
            xAxisValue = xAxisValue.substringToIndex(xAxisValue.startIndex.advancedBy(4)) + "s"
        }
        return xAxisValue
    }
}