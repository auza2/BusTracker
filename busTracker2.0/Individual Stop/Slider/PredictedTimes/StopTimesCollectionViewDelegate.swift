//
//  File.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/15/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class StopTimesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{    
    //*** PredictionsViewModel
    var predictionViewModel:PredictionsViewModel?
    var routeCollectionView: UICollectionView?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return predictionViewModel?.numberOfRows ?? 0
    }
    
    func numberOfSections(in: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routeCell", for: indexPath) as! RouteCell

        let routeCellViewModel = predictionViewModel?.cellForIndex(indexPath.row)
        cell.configure(routeCellViewModel!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 84)
    }

    func reloadStopTimes(){
        routeCollectionView?.reloadData()
    }
}



