//
//  tabBar.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/16/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class tabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let favorite = Favorites(collectionViewLayout: flowLayout)
        favorite.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        let searchVC = SearchBusRoutes(style: .plain)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        let vcs = [favorite,searchVC]
        viewControllers = vcs.map { UINavigationController(rootViewController: $0) }

        setUpNavigationBars(in: vcs)
        view.backgroundColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
    }
    
    func setUpNavigationBars(in viewControllers:[UIViewController]){
        for vc in viewControllers {
            if let navigationBar = vc.navigationController?.navigationBar{
                navigationBar.prefersLargeTitles = true
                navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                navigationBar.prefersLargeTitles = true
                navigationBar.barTintColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
                navigationBar.backgroundColor = #colorLiteral(red: 0.2, green: 0.8, blue: 1, alpha: 1)
                navigationBar.isTranslucent = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
