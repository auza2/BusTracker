//
//  Stop.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/11/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit
import Foundation

class OneStop: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var route: Route?
    var direction: Direction?
    var stop: Stop?
    
    internal var networkClient = NetworkingClient.shared
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let mySerialQueue = DispatchQueue(label: "drawOnMap")
    var points: [Point]?
    var vehicles: [Vehicle]?
    
    lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.mainViewDelegate = self
        return menuBar
    }()
    
    var directionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
        label.textColor = UIColor.white
        let titleAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedStringKey.foregroundColor: UIColor.white]
        let titleString = NSAttributedString(string: "to DIRECTION", attributes: titleAttributes)
        label.attributedText = titleString
        return label
    }()
    
    lazy var stopTimesCollectionViewDelegate: StopTimesCollectionViewDelegate = {
        let delegate = StopTimesCollectionViewDelegate()
        return delegate
    }()
    
    lazy var mapDelegate: MapDelegate = {
        let delegate = MapDelegate()
        return delegate
    }()
    
    override func viewDidLoad() {
        setUpNavigationItem()
        setUpSlideCollectionView()
        setUpMenuBarAndDirectionLabel()
        
        edgesForExtendedLayout = []
//        performSelector(inBackground: #selector(fetchPredictions), with: nil)
        
        activityIndicator.startAnimating()
//        mySerialQueue.async {
//            self.fetchPredictions()
//        }
//
//        mySerialQueue.async {
//            self.fetchVehiclesUsingID()
//        }
//
//        mySerialQueue.async {
//            self.fetchPatterns()
//        }
        
        self.fetchPredictions()
        // This is just a hack, I'm not sure why the serial queue is not working the way I inteded it to so I'm just adding function calls where
        // the networkclient finally returns something instead of trusting the serial queue to start the next function when the previous one ends
    }
    
    func setUpNavigationItem(){
        navigationItem.title = stop?.name ?? "No Stop Name"
        directionLabel.text = direction?.dir ?? "No Direction"
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator) // To-do-- fix does not show up
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStop))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bus"), style: .plain, target: self, action: #selector(saveStop))
    }
    
    func setUpSlideCollectionView(){
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(MapCollectionViewCell.self, forCellWithReuseIdentifier: "mapCollectionViewCell")
        collectionView?.register(RouteCollectionViewCell.self, forCellWithReuseIdentifier: "routeCollectionViewCell")
        collectionView?.isPagingEnabled = true
        collectionView?.contentInset = UIEdgeInsets(top: 75, left: 0, bottom: 0, right: 0)
        collectionView?.backgroundColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
    }
    
    func setUpMenuBarAndDirectionLabel(){
        view.addSubview(menuBar)
        view.addSubview(directionLabel)
        
        view.addContstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addContstraintsWithFormat(format: "H:|-20-[v0]|", views: directionLabel)
        view.addContstraintsWithFormat(format: "V:|[v0(25)][v1(50)]", views: directionLabel,menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in: UICollectionView) -> Int{
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row ==  0){
            // Show Times
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routeCollectionViewCell", for: indexPath) as! RouteCollectionViewCell
            cell.routeCollectionView.delegate = stopTimesCollectionViewDelegate
            cell.routeCollectionView.dataSource = stopTimesCollectionViewDelegate
            stopTimesCollectionViewDelegate.routeCollectionView = cell.routeCollectionView
            cell.routeCollectionView.register(RouteCell.self, forCellWithReuseIdentifier: "routeCell")
            cell.frame = collectionView.frame
            
            return cell
        }else{
            // Show Map
            let mapCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
            mapCell.mapDelegate = self.mapDelegate
            if let viewModel = mapDelegate.mapViewModel, let predictions = self.stopTimesCollectionViewDelegate.predictionViewModel{
                mapCell.mapViewModel = viewModel
                mapCell.predictionViewModel = predictions
                mapCell.drawPattern()
                mapCell.drawVehicles()
            }
            return mapCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height-collectionView.contentInset.top-self.tabBarController!.tabBar.frame.height) //!
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalbarLeftAnchorContstraint?.constant = scrollView.contentOffset.x / 2
        print(scrollView.contentOffset.x)
//        print(menuBar.horizontalbarLeftAnchorContstraint?.constant) // goes back and forth
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(item: Int(targetContentOffset.pointee.x/menuBar.frame.width), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func scrollToMenuIndex(_ menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally , animated: true)
    }
    
    // MARK: Network Calls
    
    @objc func fetchPredictions(){
//        print("fetchPredictions")
        guard let stopId = stop?.id else {return}
        networkClient.getBusInformation(.getPredictions(stopId: stopId), success: { (wrapper) in
            // To-do: give predictions to predictionviewmodel in the stop time delegate
            let predictions = wrapper.bustimeresponses.prd ?? [Prediction]()
            self.stopTimesCollectionViewDelegate.predictionViewModel = PredictionsViewModel(predictions,route: self.route!,direction: self.direction!,stop: self.stop!)
//            print("fetchPredictions-middle-0")
             DispatchQueue.main.async { [unowned self] in
                self.stopTimesCollectionViewDelegate.reloadStopTimes()
                self.activityIndicator.stopAnimating()
                print("fetchPredictions-middle-1-- fetchvehiclesusing id should be after this call")
            }
//            print("fetchPredictions-middle-2: numPredicted \(self.stopTimesCollectionViewDelegate.predictionViewModel?.predictions.count)")
            self.fetchVehiclesUsingID() // Hack
        })
//        print("fetchPredictions-end")
    }
    
    @objc func fetchPatterns(){
        print("fetchPatterns")
        guard let rt = route?.code else {return}
        networkClient.getBusInformation(.getPatterns(route: rt), success: { (wrapper) in
//            DispatchQueue.main.async { [unowned self] in
//                // To-do: give predictions to predictionviewmodel in the stop time delegate
                let patterns = wrapper.bustimeresponses.ptr!

                if patterns.count > 1 {
                    self.points = patterns[0].pointers!
                    print("DEGUBBING")
                }
                
                self.setMapViewModels() // Hack
//            }
        })
         print("fetchPatterns-end")
    }
    
    @objc func fetchVehiclesUsingID(){
        print("fetchingVId")
        guard let vehicleIds = stopTimesCollectionViewDelegate.predictionViewModel?.getVehicleIds() else {return}
        networkClient.getBusInformation(.getVehiclesUsingVehicles(vehicles: vehicleIds), success: { (wrapper) in
//            DispatchQueue.main.async { [unowned self] in
                // To-do: give predictions to predictionviewmodel in the stop time delegate
                self.vehicles = wrapper.bustimeresponses.vehicle ?? [Vehicle]()
                self.fetchPatterns() // Hack
//            }
        })
        print("fetchingVId-end")
    }
    
    func setMapViewModels(){
        guard let patternPoints = points, let routeVehicles = vehicles else { return } // To-do create error message
        let mapViewModel = MapViewModel(patternPoints,routeVehicles)
        self.mapDelegate.mapViewModel = mapViewModel
        DispatchQueue.main.async { [unowned self] in
            self.collectionView?.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc func saveStop(){
       
        let favoriteStop = FavoriteStop(direction!, route!, stop!)
        var entries = getSavedData()
        
        let alreadySaved = entries.contains{ element in
            element.stop?.id == stop?.id
        }
        
        if !alreadySaved{
            entries.append(favoriteStop)
            
            let savedData = NSKeyedArchiver.archivedData(withRootObject: entries)
            let userDefault = UserDefaults.standard
            userDefault.set(savedData ,forKey: "FavoriteStops")
//            print("saving \(stop!.latitude) , \(stop!.longitude)")
        }
    }
    
    func getSavedData()->[FavoriteStop]{
        var entries = [FavoriteStop]()
        if let savedEntriesData = UserDefaults.standard.object(forKey: "FavoriteStops") as? Data, let savedEntries = NSKeyedUnarchiver.unarchiveObject(with: savedEntriesData) as? [FavoriteStop]{
            entries = savedEntries
        }
        return entries
    }
    
    // ----- For future functionality
    
    @objc func fetchVehiclesUsingRoute(){
        guard let rt = route?.code else {return}
        networkClient.getBusInformation(.getVehiclesUsingRoute(route: rt), success: { (wrapper) in
            DispatchQueue.main.async { [unowned self] in
                // To-do: give predictions to predictionviewmodel in the stop time delegate
                self.vehicles = wrapper.bustimeresponses.vehicle ?? [Vehicle]()
            }
        })
    }
}

