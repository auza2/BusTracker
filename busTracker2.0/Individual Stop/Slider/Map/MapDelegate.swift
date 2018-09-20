//
//  MapDelegate.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/27/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit
import GoogleMaps

class MapDelegate: NSObject, GMSMapViewDelegate{
    var mapViewModel: MapViewModel?
    var prevSelectedCirc: CircleMarker?
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        if let stopInfo = stopNames[marker.title!]{
//            openIndividualStop(stopInfo)
//        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let iconView = marker.iconView as? CircleMarker{
            if prevSelectedCirc != iconView{
                iconView.changeSize()
                prevSelectedCirc?.changeSize()
                prevSelectedCirc = iconView
            }else{
                prevSelectedCirc?.changeSize()
                prevSelectedCirc = nil
            }
        }

        return true
    }
}
