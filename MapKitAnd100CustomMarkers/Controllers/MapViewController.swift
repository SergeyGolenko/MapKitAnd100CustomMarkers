//
//  ViewController.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 15.01.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        let annotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
        mapView.removeAnnotations(annotations)
        generateAnnoLoc()
    }
    
    //MARK: - Properties
    let latitudeCoordinateUkraine = CLLocationDegrees(49.22)
    let longitudeCoordinateUkraine = CLLocationDegrees(31.10)
    let annotationIdentifier = "circle"
    

    //MARK: - Functions
    func randomNumberForLabel(from:Int,to:Int) -> String{
        let number = Int.random(in: from...to)
        return String(number)
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func loadCoordinateUkraine(){
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeCoordinateUkraine, longitude: longitudeCoordinateUkraine)
        let longitudeUkraine = CLLocationDistance(131_600_0)
        let latitudeUkraine = CLLocationDistance(750_000)
        let centerUkraine = MKCoordinateRegion(center: locationCoordinate2D, latitudinalMeters: latitudeUkraine, longitudinalMeters:longitudeUkraine)
        mapView.setRegion(centerUkraine, animated: true)
    }
 
    func generateAnnoLoc() {
        var num = 0
        while num != 100 {
            num += 1
            //Add Annotation
            let annotation = CircleAnnotation(coordinate: CLLocationCoordinate2D(latitude:CLLocationDegrees(randomBetweenNumbers(firstNum: 46, secondNum: 52)), longitude: CLLocationDegrees(randomBetweenNumbers(firstNum:23, secondNum: 39))))
            mapView.addAnnotation(annotation)
        }
    }
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadCoordinateUkraine()
        generateAnnoLoc()
        
        mapView.register(CircleAnnotationView.self,forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.register(ClusterAnnotationView.self,forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        mapView.isHidden = false
        mapView.isZoomEnabled = true
    }
}


extension MapViewController: MKMapViewDelegate {
    
 //сообщает делегату, что было выбрано одно из представлений его аннотации
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
     //   view.clusteringIdentifier = nil
        
        guard view is ClusterAnnotationView else { return }
        // if the user taps a cluster, zoom in
        
        let currentSpan = mapView.region.span
        //Приближает в два раза(зум)
        let zoomSpan = MKCoordinateSpan(latitudeDelta: currentSpan.latitudeDelta / 2.0, longitudeDelta: currentSpan.longitudeDelta / 2.0)
            //Перемещает вид карты на выбранную аннотацию
        let zoomCoordinate = view.annotation?.coordinate ?? mapView.region.center
        let zoomed = MKCoordinateRegion(center: zoomCoordinate, span: zoomSpan)
        mapView.setRegion(zoomed, animated: true)
    }
    
   
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("ZOOMING")
              
 
}
    
 
    

}
