//
//  Structs.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/17/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

//struct Route: Decodable {
//    let name: String?
//    let code: String?
//    private enum CodingKeys: String, CodingKey {
//        case name = "rtnm"
//        case code = "rt"
//    }
//}

struct ApiWrapper: Decodable{
    let bustimeresponses: bustimeResponse
    private enum CodingKeys: String, CodingKey {
        case bustimeresponses = "bustime-response"
    }
}
struct bustimeResponse: Decodable{
    let routes: [Route]?
    let directions: [Direction]?
    let stops: [Stop]?
    let prd: [Prediction]?
    let vehicle: [Vehicle]?
    let ptr: [Pattern]?
}

//struct Direction: Decodable{
//    let dir : String?
//}

struct Prediction: Decodable{
    let routeDesc: String?
    let predictedTime: String?
    let routeDir: String?
    let vehicleID: String?
    
    private enum CodingKeys: String, CodingKey {
        case routeDesc = "rt"
        case routeDir = "rtdir"
        case predictedTime = "prdtm"
        case vehicleID = "vid"
    }
}

//struct Stop: Decodable{
//    let id: String?
//    let name: String?
//    let latitude: Double?
//    let longitude: Double?
//    
//    private enum CodingKeys: String, CodingKey {
//        case id = "stpid"
//        case name = "stpnm"
//        case latitude = "lat"
//        case longitude = "lon"
//    }
//}

struct Pattern: Decodable{
    let patternId: Double?
    let line: Double?
    let routeDirection: String?
    let pointers: [Point]?
    
    private enum CodingKeys: String, CodingKey {
        case patternId = "pid"
        case line = "ln"
        case routeDirection = "rtdir"
        case pointers = "pt"
    }
}

struct Point: Decodable{
    let seq: Int?
    let latitude: Double?
    let longitude: Double?
    let type: String?
    let stopId: String?
    let stopName: String?
    let pointDistance: Double?
    
    private enum CodingKeys: String, CodingKey {
        case seq = "seq"
        case latitude = "lat"
        case longitude = "lon"
        case type = "typ"
        case stopId = "stpid"
        case stopName = "stpnm"
        case pointDistance = "pdist"
    }
}

struct Vehicle: Decodable{
    let latitude: String?
    let longitude: String?
    let id: String?
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case id = "vid"
    }
}
