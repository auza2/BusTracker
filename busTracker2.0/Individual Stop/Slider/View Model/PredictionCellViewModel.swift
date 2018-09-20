//
//  PredictionCellViewModel.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/18/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

final class PredictionsViewCellModel: RouteCellViewModel{
    internal static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyyMMdd HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "CDT") // Chicago's time zone is CDT
        return formatter
    }()
    
    var prediction: Prediction
    var timeLabelText: String
    var timeLabelBackgroundColor: UIColor
    
    init(prediction: Prediction,route: Route, direction: Direction, stop: Stop){
        self.prediction = prediction
        
        let date = PredictionsViewCellModel.formatter.date(from: prediction.predictedTime!)
        var minutesTill = date?.timeIntervalSince(Date()) ?? 0.0
        minutesTill = minutesTill/60
        
        switch minutesTill {
        case -100..<4:
            timeLabelBackgroundColor = .red
        case 4...10:
            timeLabelBackgroundColor = .yellow
        default:
            timeLabelBackgroundColor = .lightGray
        }
        
        let minuteAsInt = Int(round(minutesTill))
        timeLabelText = minuteAsInt < 2 ? "\(minuteAsInt)\nmin" : "\(minuteAsInt)\nmins"
        
        super.init(route: route,direction: direction,stop: stop)
    }
}
