//
//  Stop.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

class Stop: NSObject, NSCoding, Decodable{
    let id: String?
    let name: String?
    let latitude: Double?
    let longitude: Double?
    
    private struct PropertyKeys{
        static let id = "id"
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "stpid"
        case name = "stpnm"
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(_ id:String, _ name:String, _ latitude:Double,_ longitude:Double){
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKeys.id)
        aCoder.encode(name, forKey: PropertyKeys.name )
        aCoder.encode(latitude, forKey: PropertyKeys.latitude)
        aCoder.encode(longitude, forKey: PropertyKeys.longitude)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeObject(forKey: "id") as? String,
            let name = aDecoder.decodeObject(forKey: "name") as? String,
            let lat = aDecoder.decodeObject(forKey: "latitude") as? Double,
            let lon = aDecoder.decodeObject(forKey: "longitude") as? Double
            else { return nil }
        self.init( id , name, lat, lon)
    }
}
