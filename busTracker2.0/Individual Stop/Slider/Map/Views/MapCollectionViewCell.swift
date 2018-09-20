//
//  MapCollectionViewCell.swift
//  
//
//  Created by Jamie Auza on 7/23/18.
//

import UIKit
import GoogleMaps

class MapCollectionViewCell: BaseCollectionViewCell{
    var stop: Stop?
    var route: Route?
    var mapDelegate: MapDelegate?
    var predictionViewModel:PredictionsViewModel? {
        didSet{
            let latitude = Double((predictionViewModel?.stop.latitude)!)
            let longitude = Double((predictionViewModel?.stop.longitude)!)
            mapView.camera = GMSCameraPosition.camera(withLatitude: latitude,
                                                      longitude: longitude,
                                                      zoom: 14)
            print(latitude,longitude)
        }
    }
    var mapViewModel: MapViewModel!
    
    lazy var camera : GMSCameraPosition = {
        // To-do change the lat/long to the user's current location
        let latitude = Double(41.9937687)
        let longitude = Double(-87.6763563)
//        let camera = GMSCameraPosition.camera(withLatitude: (self.mapViewModel?.points[0].latitude!)!,
//                                              longitude: (self.mapViewModel?.points[0].longitude!)!,
//                                              zoom: 14)
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: 14)
        return camera
    }()
    
    lazy var mapView: GMSMapView = {
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = mapDelegate
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
        
    }()
    
    override func setUpView(){
        addSubview(mapView)
        
        addContstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        addContstraintsWithFormat(format: "V:|[v0]|", views: mapView)
    }
    
    func drawPattern(){
        print("3 - drawing")
        
        
        let path = GMSMutablePath()
        
        for point in mapViewModel.points{
            path.addLatitude(point.latitude!, longitude: point.longitude!)
            
        }
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.geodesic = true
        polyline.map = mapView
        let strokeStyle = GMSStrokeStyle.gradient(from: UIColor.cyan, to: UIColor.blue)
        polyline.spans = [GMSStyleSpan(style: strokeStyle)]
        
        for point in mapViewModel.points {
            if point.type == "S"{
                let position = CLLocationCoordinate2D(latitude: point.latitude!, longitude: point.longitude!)
                let marker = GMSMarker(position: position)
                marker.title = point.stopName
                marker.isFlat = true
                marker.opacity = 1
                
                let circleCenter = CLLocationCoordinate2D(latitude: point.latitude!, longitude: point.longitude!)
                let circ = GMSCircle(position: circleCenter, radius: 3)
                circ.isTappable = true
                
                circ.fillColor = #colorLiteral(red: 0.4, green: 0, blue: 1, alpha: 1)
                circ.userData = stop // change to stop so taht we can tap on it
                
                circ.map = mapView
            }
        }
        
        // Draw stop
        let position = CLLocationCoordinate2D(latitude: (predictionViewModel?.stop.latitude!)!, longitude: (predictionViewModel?.stop.longitude!)!)
        let marker = GMSMarker(position: position)
        marker.title = predictionViewModel?.stop.name
        marker.isFlat = true
        marker.opacity = 1
        
        let cM = CircleMarker(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cM.stopText = predictionViewModel?.stop.name ?? " "
        marker.iconView = cM
        marker.title = predictionViewModel?.stop.name
        marker.map = mapView
    }
    
    func drawVehicles(){
        if mapViewModel.vehicles.count == 0 {
            return
        }
        
        for vehicle in mapViewModel.vehicles{
            let lat = Double(vehicle.latitude!)!
            let lon = Double(vehicle.longitude!)!
            let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let marker = GMSMarker(position: position)
            marker.title = vehicle.id
            marker.isFlat = false
            marker.opacity = 1
            
            let cM = BusMarker(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let time = predictionViewModel?.getTimeForVehicle(withId: vehicle.id!) ?? "Unknown"
            cM.stopText = "\(String(describing: time))"
            marker.iconView = cM
            marker.title = vehicle.id
            marker.map = mapView

//            let marker = GMSMarker(position: position)
//            marker.isFlat = true
//            marker.opacity = 1
//            marker.title = vehicle.id
//            marker.icon = UIImage(named: "bus")
//            marker.map = mapView
        }
    }
}
