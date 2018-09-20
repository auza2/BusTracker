//
//  gradientBackGround.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/18/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class GradientBackground: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [UIColor.Blue.cgColor, UIColor.Purple.cgColor]
        gradientLayer.locations = [0,1]
        gradientLayer.startPoint = CGPoint(x:1,y:0)
        gradientLayer.endPoint = CGPoint(x:1,y:1)
        self.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
