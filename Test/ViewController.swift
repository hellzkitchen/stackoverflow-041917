//
//  ViewController.swift
//  Test
//
//  Created by mg on 4/19/17.
//  Copyright © 2017 mg. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var searchBar: UISearchBar!
    private var label: UILabel!
    
    var searchController:UISearchController! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        let location = CLLocation(latitude: 40.705260, longitude: -74.005515)
        updateMap(location)
        
        let currentLoc = MKPointAnnotation()
        currentLoc.title = "Maiden ln"
        currentLoc.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let currentLocAnnotation = MKPinAnnotationView(annotation: currentLoc, reuseIdentifier: nil)
        mapView.addAnnotation(currentLocAnnotation.annotation!)
        
        let Loews = MKPointAnnotation()
        Loews.title = "Loews"
        Loews.coordinate = CLLocationCoordinate2D(latitude: 40.774975, longitude: -73.981640)
        let LoewsAnnotation = MKPinAnnotationView(annotation: Loews, reuseIdentifier: nil)
        mapView.addAnnotation(LoewsAnnotation.annotation!)
        
        let Loews34 = MKPointAnnotation()
        Loews34.title = "Loews34"
        Loews34.coordinate = CLLocationCoordinate2D(latitude: 40.752452, longitude: -73.994869)
        let Loews34Annotation = MKPinAnnotationView(annotation: Loews34, reuseIdentifier: nil)
        mapView.addAnnotation(Loews34Annotation.annotation!)
        
        
        let searchTable = storyboard!.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        
        searchController = UISearchController(searchResultsController: searchTable)
        searchController?.searchResultsUpdater = searchTable
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Input text"
        navigationItem.titleView = searchController?.searchBar
        
        searchTable.mapView = mapView
        searchTable.handleMapSearchDelegate = self
        
    }
    
    func updateMap(_ location: CLLocation)  {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        mapView.setRegion(region, animated: true)
    }
    
}
extension ViewController: HandleMapSearch   {
    func dropPinZoomIn(placemark: MKAnnotation)    {
        updateMap(CLLocation(latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude))
        searchController.searchBar.text = placemark.title!
    }
}

