//
//  StopTableCell.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/17/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class StopTableCell: BaseTableCell{
    var stopLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        return label
    }()
    
    override func setUpView() {
        addSubview(stopLabel)
        
        addContstraintsWithFormat(format: "H:|-[v0]", views: stopLabel)
        addContstraintsWithFormat(format: "V:|-[v0(25)]", views: stopLabel)
        backgroundColor = UIColor.frostWhite
        
    }
}
