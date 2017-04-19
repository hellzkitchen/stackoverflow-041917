//
//  SearchTableViewController.swift
//  Test
//
//  Created by mg on 4/19/17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch    {
    func dropPinZoomIn(placemark: MKAnnotation)
}

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var mapView: MKMapView? = nil
    var matchingItems = [MKAnnotation]()
    var handleMapSearchDelegate:HandleMapSearch? = nil
    
    func updateSearchResults(for searchController: UISearchController) {
        
        matchingItems = []
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        
        for item in self.mapView!.annotations    {
            let title = item.title! as! String
            
            if title.hasPrefix(searchBarText) && searchBarText != ""  {
                matchingItems.append(item)
            }
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let selectedItem = matchingItems[indexPath.row]
        cell.textLabel?.text = selectedItem.title!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row]
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    
}
