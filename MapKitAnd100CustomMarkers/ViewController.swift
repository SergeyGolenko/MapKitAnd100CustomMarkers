//
//  ViewController.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 15.01.2021.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,MKMapViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - Actions
    
    
    //MARK: - Properties
    var  manager = CLLocationManager()
    
    //MARK: - Functions
    func loadCoordinateUkraine(){
        let latitudeCoordinate = CLLocationDegrees(48.22)
        let longitudeCoordinate = CLLocationDegrees(31.10)
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate)
        let longitudeUkraine = CLLocationDistance(131_600_0)
        let latitudeUkraine = CLLocationDistance(893_000)
        
        let centerUkraine = MKCoordinateRegion(center: locationCoordinate2D, latitudinalMeters: latitudeUkraine, longitudinalMeters:longitudeUkraine)
        mapView.setRegion(centerUkraine, animated: true)
    }
    

        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
       loadCoordinateUkraine()
    }


}

