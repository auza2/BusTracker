//
//  NetworkParameters.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/17/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

enum NetworkParameter {
    case getRoutes
    case getDirection(route: String)
    case getPatterns(route: String)
    case getStops(route: String, direction: String)
    case getPredictions(stopId: String)
    case getVehiclesUsingRoute(route: String)
    case getVehiclesUsingVehicles(vehicles: [String])
}
