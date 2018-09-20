//
//  FavoriteStop.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

class FavoriteStop: NSObject, NSCoding, Decodable {
    let direction: Direction?
    let route: Route?
    let stop: Stop?
    
    private struct PropertyKeys{
        static let direction = "direction"
        static let route = "route"
        static let stop = "stop"
    }
    init(_ dir:Direction,_ rt:Route,_ stp:Stop ){
        self.direction = dir
        self.route = rt
        self.stop = stp
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(direction, forKey: PropertyKeys.direction)
        aCoder.encode(route, forKey: PropertyKeys.route)
        aCoder.encode(stop, forKey: PropertyKeys.stop)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let dir = aDecoder.decodeObject(forKey: "direction") as? Direction,
            let rt = aDecoder.decodeObject(forKey: "route") as? Route,
            let stp = aDecoder.decodeObject(forKey: "stop") as? Stop
            else { return nil }
        self.init(dir,rt,stp)
    }
}
