//
//  FavoriteStopViewModel.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 8/6/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import Foundation

final class FavoriteStopsViewModel{
    var favoriteStops: [FavoriteStop]
    var count: Int
    var isEditing: Bool = false
    
    init(favorites:[FavoriteStop]) {
        self.favoriteStops = favorites
        count = favorites.count
    }
    
    func cellForIndex(_ index: Int) -> RouteCellViewModel{
        let favoriteStop = favoriteStops[index]
        let routeCellViewModel = RouteCellViewModel(route: favoriteStop.route!, direction: favoriteStop.direction!, stop: favoriteStop.stop!)
        routeCellViewModel.isEditing = isEditing
        return routeCellViewModel
    }
    
    func favoriteStopFor(_ index: Int) -> FavoriteStop{
        return favoriteStops[index]
    }
    
    func deleteFavorite(){
        
    }
}
