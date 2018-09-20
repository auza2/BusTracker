//
//  RouteCollectionViewCell.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/15/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class RouteCollectionViewCell: BaseCollectionViewCell{
    lazy var routeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.backgroundView = GradientBackground(frame: frame)
        collectionView.backgroundColor = UIColor.Blue
        return collectionView
    }()
    
    override func setUpView() {
        addSubview(routeCollectionView)
//        routeCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 75, right: 0)
        addContstraintsWithFormat(format: "H:|[v0]|", views: routeCollectionView)
        addContstraintsWithFormat(format: "V:|[v0]|", views: routeCollectionView)
        
    }
    
    func reloadCollectionView(){
        routeCollectionView.reloadData()
    }
    
}
