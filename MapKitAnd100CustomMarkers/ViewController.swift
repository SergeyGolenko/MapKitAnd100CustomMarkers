//
//  ViewController.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 15.01.2021.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,MKMapViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - Actions
    
    
    //MARK: - Properties
    let annotation = MKPointAnnotation()
    let latitudeCoordinate = CLLocationDegrees(49.22)
    let longitudeCoordinate = CLLocationDegrees(31.10)
   

    
    //MARK: - Functions
    func loadCoordinateUkraine(){
       
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate)
        let longitudeUkraine = CLLocationDistance(131_600_0)
        let latitudeUkraine = CLLocationDistance(750_000)
        
        let centerUkraine = MKCoordinateRegion(center: locationCoordinate2D, latitudinalMeters: latitudeUkraine, longitudinalMeters:longitudeUkraine)
        mapView.setRegion(centerUkraine, animated: true)
    }
    
    func addMarker(){
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate)
        annotation.title = "This is Ukraine"
        mapView.addAnnotation(annotation)
    }
    
   
    
 

        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCoordinateUkraine()
        addMarker()
       
    }


}

