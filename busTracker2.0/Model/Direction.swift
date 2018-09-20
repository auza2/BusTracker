//
//  Direction.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

class Direction: NSObject, NSCoding, Decodable{
    let dir : String?
    private struct PropertyKeys{
        static let dir = "dir"
    }
    init(_ dir:String){
        self.dir = dir
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dir, forKey: PropertyKeys.dir)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        guard let dir = aDecoder.decodeObject(forKey: "dir") as? String
            else { return nil }
        self.init(dir)
    }
}
