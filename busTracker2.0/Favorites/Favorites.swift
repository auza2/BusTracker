//
//  ViewController.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/10/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class Favorites: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var favoriteStopViewModel:FavoriteStopsViewModel?
    override var isEditing: Bool{
        didSet{
            collectionView?.allowsSelection = !isEditing
            favoriteStopViewModel?.isEditing = isEditing
            collectionView?.reloadData()
            navigationItem.rightBarButtonItem = isEditing ? UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editFavorites)) : UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editFavorites))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpView()
        _ = getSavedData()
        
        // Set up navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editFavorites))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadCollectionView()
    }
    
    func reloadCollectionView(){
        _ = getSavedData()
        collectionView?.reloadData()
    }
    
    func setUpView(){
        collectionView?.backgroundView = GradientBackground(frame: view.frame)
        collectionView?.backgroundColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
        collectionView?.register(RouteCell.self, forCellWithReuseIdentifier: "routeCell")
        navigationItem.title = "Favorites"
    }
    
    func getSavedData()->[FavoriteStop]{
        var favorites = [FavoriteStop]()
        if let savedEntriesData = UserDefaults.standard.object(forKey: "FavoriteStops") as? Data, let savedEntries = NSKeyedUnarchiver.unarchiveObject(with: savedEntriesData) as? [FavoriteStop]{
            favorites = savedEntries
        }
        favoriteStopViewModel = FavoriteStopsViewModel(favorites:favorites)
        favoriteStopViewModel?.isEditing = isEditing
        return favorites
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteStopViewModel?.count ?? 0
    }
    
    override func numberOfSections(in: UICollectionView) -> Int{
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "routeCell", for: indexPath) as! RouteCell
        
        let routeCellViewModel = favoriteStopViewModel?.cellForIndex(indexPath.row)
        cell.configure(routeCellViewModel!)
        cell.editingButton.addTarget(self, action: #selector(removeFavorite(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 84)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flowLayout = UICollectionViewFlowLayout()
        let stop = OneStop(collectionViewLayout: flowLayout)
        let favoriteStop = favoriteStopViewModel?.favoriteStopFor(indexPath.row)
        stop.direction = favoriteStop?.direction
        stop.route = favoriteStop?.route
        stop.stop = favoriteStop?.stop
        navigationController?.pushViewController(stop, animated: true)
    }
    
    @objc func editFavorites(){
        isEditing = !isEditing
    }
    
    @objc func removeFavorite(sender: UIButton){
        if let cell = sender.superview as? RouteCell {
            let ac = UIAlertController(title: "Delete Favorite Stop?", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                let indexPath = self.collectionView?.indexPath(for: cell)!

                self.collectionView?.performBatchUpdates({
                    self.collectionView?.deleteItems(at:[indexPath!])
                    var entries = self.getSavedData()
                    entries.remove(at: indexPath!.row)
                    
                    let savedData = NSKeyedArchiver.archivedData(withRootObject: entries)
                    let userDefault = UserDefaults.standard
                    userDefault.set(savedData ,forKey: "FavoriteStops")
                    self.reloadCollectionView()
                }, completion:nil)
                
               
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(ac, animated: true)
        }
    }
}


