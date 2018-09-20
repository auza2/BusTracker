//
//  RouteCellViewModel.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//
import UIKit
import Foundation

class RouteCellViewModel{
    // Stop Name
    // Route Code
    // Direction
    // Predicted Minute
    var route: Route?
    var direction: Direction?
    var stop: Stop?
    
    var stopNameText: String
    var routeDirectionText: String
    var routeCodeText: NSAttributedString
    var isEditing: Bool = false
    
    init(route: Route, direction: Direction, stop: Stop){
        self.route = route
        self.direction = direction
        self.stop = stop
        
        
        stopNameText = stop.name!
        routeDirectionText = direction.dir!
        
        let stringAttr = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title1), NSAttributedStringKey.foregroundColor: UIColor.Purple]
        let routeCodeString =  NSAttributedString(string: "\(route.code!)", attributes: stringAttr)
        routeCodeText = routeCodeString
    }
}
