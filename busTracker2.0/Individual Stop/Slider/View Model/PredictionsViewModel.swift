//
//  PredictionsViewModel.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/18/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit
import Foundation

final class PredictionsViewModel {
    var route: Route
    var direction: Direction
    var stop: Stop
    
    let predictions: [Prediction]
    let numberOfRows: Int
    var dictionaryOfVehicleAndTimeLabel = [String: String]()
    
    public init(_ predictions: [Prediction], route: Route, direction: Direction, stop: Stop){
        self.predictions = predictions
        self.numberOfRows = predictions.count
        self.route = route
        self.direction = direction
        self.stop = stop
        
        for pred in predictions{
            let date = PredictionsViewCellModel.formatter.date(from: pred.predictedTime!)
            var minutesTill = date?.timeIntervalSince(Date()) ?? 0.0
            minutesTill = minutesTill/60
            let minuteAsInt = Int(round(minutesTill))
            dictionaryOfVehicleAndTimeLabel[pred.vehicleID!] = minuteAsInt < 2 ? "\(minuteAsInt) min" : "\(minuteAsInt) mins"
        }
    }
    
    func cellForIndex(_ index: Int) -> PredictionsViewCellModel{
        let pcvm = PredictionsViewCellModel(prediction: predictions[index],route: route,direction: direction,stop: stop)
        return pcvm
    }
    
    func getVehicleIds() -> [String]{
        var ids = [String]()
        for pred in predictions{
            ids.append(pred.vehicleID!)
        }
        return ids
    }
    
    func getTimeForVehicle(withId vehicleId: String) -> String{
        return dictionaryOfVehicleAndTimeLabel[vehicleId]!
    }
}
