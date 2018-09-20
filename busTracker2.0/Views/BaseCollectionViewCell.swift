//
//  baseTableCell.swift
//  Vitae2.0
//
//  Created by Jamie Auza on 6/20/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    func setUpView(){
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func layoutSubviews() {
        setUpView()
    }
}

extension UIView{
    func addContstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
