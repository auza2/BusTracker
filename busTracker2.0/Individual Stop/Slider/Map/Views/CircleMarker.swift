//
//  CircleMarker.swift
//  busTracker
//
//  Created by Jamie Auza on 7/22/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

@IBDesignable
class CircleMarker: UIView {
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    var originalFrame: CGRect?
    var isSelected: Bool = false
    var sizeOfExpanded: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func layoutSubviews() {
        setUpView()
    }
    
    lazy var innerView: UIView = {
        let view = UIView(frame: self.frame)
        view.backgroundColor = UIColor.purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "StopInfo"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    var stopText: String = "" {
        didSet{
            infoLabel.text = stopText
            sizeOfExpanded = CGFloat(stopText.count*10)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView(){
        originalFrame = frame
        backgroundColor = UIColor.white
        addSubview(innerView)
        addSubview(infoLabel)

        innerView.widthAnchor.constraint(equalToConstant: originalFrame!.height-10).isActive = true
        innerView.heightAnchor.constraint(equalToConstant: originalFrame!.height-10).isActive = true

        addConstraint(NSLayoutConstraint(item: innerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: innerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .leading, relatedBy: .equal, toItem: innerView, attribute: .trailing, multiplier: 1, constant: 5))
        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .centerY, relatedBy: .equal, toItem: innerView, attribute: .centerY, multiplier: 1, constant: 0))

        innerView.layoutIfNeeded()
        innerView.layer.cornerRadius = innerView.frame.height/2
        innerView.layer.masksToBounds = true
        innerView.clipsToBounds = true
        
        layer.cornerRadius = frame.height/2
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.8
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeColor(){
        innerView.backgroundColor = UIColor.blue
    }
    
    func changeSize(){
        if !isSelected{
            UIView.animate(withDuration: 0.05, animations: {
                self.frame.size = CGSize(width: self.originalFrame!.width + self.sizeOfExpanded!, height: self.frame.height)
                self.layoutIfNeeded()
            }, completion: { (_) in
                self.infoLabel.isHidden = false
            })
        }else{
            UIView.animate(withDuration: 0.05, animations: {
                self.frame.size = CGSize(width: self.originalFrame!.width - self.sizeOfExpanded!, height: self.frame.height)
                self.infoLabel.isHidden = true
                self.layoutIfNeeded()
            }, completion: nil )
        }
        isSelected = !isSelected
    }
}

class BusMarker: CircleMarker{
    let busImageView: UIImageView = {
        let busImage = UIImage(named: "bus")
        let imageview = UIImageView(image: busImage)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override func setUpView(){
        super.setUpView()
        innerView.backgroundColor = UIColor.lightBlue
        innerView.addSubview(busImageView)
        
        addConstraint(NSLayoutConstraint(item: busImageView, attribute: .centerY, relatedBy: .equal, toItem: innerView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: busImageView, attribute: .centerX, relatedBy: .equal, toItem: innerView, attribute: .centerX, multiplier: 1, constant: 0))
    }
}

