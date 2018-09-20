//
//  RouteCell.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/15/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//
import UIKit

@IBDesignable
class RouteCell: BaseCollectionViewCell{
    var viewModel: RouteCellViewModel?
    
    let cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    var routeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 0.8796836703, green: 0.8796836703, blue: 0.8796836703, alpha: 1)
        label.text = "888"
        return label
    }()
    
    var stopTextView: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.textColor = UIColor.black
        label.text = "Stop Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return label
    }()
    
    var directionTextView: UITextView = {
        let label = UITextView()
        label.isEditable = false
        label.isUserInteractionEnabled = false
        label.textColor = UIColor.gray
        label.text = "Direction"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = UIColor.yellow
        label.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.blue
        label.text = "time"
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.isHidden = true
        label.numberOfLines = 2
        return label
    }()
    
    var editingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross-out"), for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    var routeColor: UIColor = #colorLiteral(red: 0.6567561529, green: 0.6567561529, blue: 0.6567561529, alpha: 1) {
        didSet{
            routeLabel.backgroundColor = routeColor
        }
    }
    
    override func setUpView() {
        addSubview(cardView)
        addSubview(routeLabel)
        addSubview(stopTextView)
        addSubview(directionTextView)
        addSubview(timeLabel)
        
        
        addContstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: cardView)
        addContstraintsWithFormat(format: "H:|-32-[v0]-[v1]-[v2]-42-|", views: routeLabel, stopTextView,timeLabel)
        addContstraintsWithFormat(format: "V:|-[v0]-|", views: cardView)
        addContstraintsWithFormat(format: "V:|-[v0]-|", views: routeLabel)
        addContstraintsWithFormat(format: "V:[v1(12)][v0(42)]", views: stopTextView,directionTextView)
        
        addConstraint(NSLayoutConstraint(item: directionTextView, attribute: .top, relatedBy: .equal, toItem: cardView, attribute: .top, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: stopTextView, attribute: .leading, relatedBy: .equal, toItem: directionTextView, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: directionTextView, attribute: .width, relatedBy: .equal, toItem: stopTextView, attribute: .width, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .centerY, relatedBy: .equal, toItem: cardView, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .height, relatedBy: .equal, toItem: cardView, attribute: .height, multiplier: 1, constant: -10))
        routeLabel.widthAnchor.constraint(equalTo: routeLabel.heightAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: timeLabel.heightAnchor).isActive = true
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 3
        cardView.layer.shadowOpacity = 0.35
        cardView.backgroundColor = UIColor.white
        
        addSubview(editingButton)
        addContstraintsWithFormat(format: "H:|-24-[v0(16)]", views: editingButton)
        addContstraintsWithFormat(format: "V:|-2-[v0(16)]", views: editingButton)
        editingButton.isHidden = true
        editingButton.layer.cornerRadius = editingButton.bounds.width/2
    }
    
    func configure(_ viewModel: PredictionsViewCellModel){
        self.viewModel = viewModel
        timeLabel.text = viewModel.timeLabelText
        timeLabel.backgroundColor = viewModel.timeLabelBackgroundColor
        timeLabel.isHidden = false
        
        stopTextView.text = viewModel.stopNameText
        directionTextView.text = viewModel.routeDirectionText
        routeLabel.attributedText = viewModel.routeCodeText
    }
    
    func configure(_ viewModel: RouteCellViewModel){
        self.viewModel = viewModel        
        stopTextView.text = viewModel.stopNameText
        directionTextView.text = viewModel.routeDirectionText
        routeLabel.attributedText = viewModel.routeCodeText
        DispatchQueue.main.async {
            self.editingButton.isHidden = !viewModel.isEditing
        }
    }
}

