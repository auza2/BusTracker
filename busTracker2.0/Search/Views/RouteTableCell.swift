//
//  RouteTableCell.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/16/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class RouteTableCell: BaseTableCell{
    let routeCode: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    
    let routeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        return label
    }()
    
    override func setUpView(){
        addSubview(routeCode)
        addSubview(routeName)
        addContstraintsWithFormat(format: "H:|-16-[v0(90)]-[v1]-|", views: routeCode,routeName)
        addContstraintsWithFormat(format: "V:|[v0]|", views: routeCode)
        addContstraintsWithFormat(format: "V:|[v0]|", views: routeName)
        
        backgroundColor = UIColor.frostWhite
    }
}
