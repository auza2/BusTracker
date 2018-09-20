//
//  SearchController.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/17/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class SearchController: UISearchController {
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setUp()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp(){
        searchBar.enablesReturnKeyAutomatically = true
        obscuresBackgroundDuringPresentation = false
        searchBar.tintColor = UIColor.Purple 
        searchBar.barTintColor = UIColor.Purple
        searchBar.backgroundColor = UIColor.lightBlue
        searchBar.placeholder = "Search Routes"
        definesPresentationContext = true
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
