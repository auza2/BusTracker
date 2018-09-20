//
//  Route.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

class Route: NSObject, NSCoding, Decodable {
    let name: String?
    let code: String?
    
    private struct PropertyKeys{
        static let name = "name"
        static let code = "code"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "rtnm"
        case code = "rt"
    }
    
    init(_ name:String, _ code:String){
        self.name = name
        self.code = code
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(code, forKey: PropertyKeys.code)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let code = aDecoder.decodeObject(forKey: "code") as? String
            else { return nil }
        self.init(name, code)
    }
}
