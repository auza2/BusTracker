//
//  Search.swift
//  busTracker2.0
//
//  Created by Jamie Auza on 7/16/18.
//  Copyright © 2018 Jamie Auza. All rights reserved.
//

import UIKit

class SearchBusRoutes: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    var routes = [Route]()
    var filteredRoutes = [Route]()
    internal var networkClient = NetworkingClient.shared
    
    let searchController = SearchController(searchResultsController: nil)
    var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpSearchController()
        setUpTableView()

        edgesForExtendedLayout = []
        performSelector(inBackground: #selector(fetchRoutes), with: nil)
    }

    func setUpNavigationItem(){
        navigationItem.title = "Search Bus Routes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
    }

    func setUpSearchController(){
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
    }
    
    func setUpTableView(){
        tableView.register(RouteTableCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.backgroundView = GradientBackground(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height))
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredRoutes = routes.filter({( route : Route) -> Bool in
            return (route.name?.lowercased().contains(searchText.lowercased()))! || (route.code?.lowercased().contains(searchText.lowercased()))!
        })
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFiltering() ? filteredRoutes.count : routes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RouteTableCell else {return UITableViewCell()}

        let stringAttr = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .largeTitle), NSAttributedStringKey.foregroundColor: UIColor.white]
        var routCodeString: NSAttributedString?
        
        if isFiltering(){
            routCodeString = NSAttributedString(string: "\(filteredRoutes[indexPath.row].code!)", attributes: stringAttr)
            cell.routeName.text = "\(filteredRoutes[indexPath.row].name!)"
        }else{
            routCodeString = NSAttributedString(string: "\(routes[indexPath.row].code!)", attributes: stringAttr)
            cell.routeName.text = "\(routes[indexPath.row].name!)"
        }
        cell.routeCode.attributedText = routCodeString
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ListOfStops
        guard let rt = isFiltering() ? filteredRoutes[indexPath.row].code : routes[indexPath.row].code else {return}
        networkClient.getBusInformation(.getDirection(route: rt), success: { (wrapper) in
            DispatchQueue.main.async { [unowned self] in
                let directions = wrapper.bustimeresponses.directions!
                let ac = UIAlertController(title: "Choose Direction", message: nil, preferredStyle: .actionSheet)
                for dir in directions{
                    ac.addAction(UIAlertAction(title: dir.dir, style: .default, handler: { action in
                        let searchStopsVC = SearchStops(style: .plain)
                        searchStopsVC.route = self.isFiltering() ? self.filteredRoutes[indexPath.row] : self.routes[indexPath.row]
                        searchStopsVC.direction = dir
                        self.navigationController?.pushViewController(searchStopsVC, animated: true)
                    }))
                }
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(ac,animated: true)
            }
        })
    }
    
    @objc func fetchRoutes(){
        networkClient.getBusInformation(.getRoutes, success: { (wrapper) in
            DispatchQueue.main.async { [unowned self] in
                        self.routes = wrapper.bustimeresponses.routes!
                        self.tableView.reloadData()
                        self.activityIndicator.stopAnimating()
                    }
        })
    }
}
