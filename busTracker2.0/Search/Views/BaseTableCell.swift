//
//  BaseTableCell.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/16/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell{
    func setUpView(){
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func layoutSubviews() {
        setUpView()
    }
}
