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
//        mapView.register(CircleAnnotation.self, forAnnotationViewWithReuseIdentifier: "circle")
    }
}

extension MapViewController : MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor circleAnnotation: MKAnnotation) -> MKAnnotationView? {
        
        guard circleAnnotation is CircleAnnotation else {return nil}
        let annotationIdentifier = "circle"
        var annotationView: MKAnnotationView?
        if let circleAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = circleAnnotationView
            annotationView?.annotation = circleAnnotation
        }
        else {
            annotationView = MKAnnotationView(annotation: circleAnnotation, reuseIdentifier: annotationIdentifier)
        }
        if let annotationView2 = annotationView {
            annotationView2.canShowCallout = true
            
            let redCircle : UIView = {
                let containerView = UIView()
                containerView.backgroundColor = .red
                containerView.setHeight(height:16)
                containerView.setWidth(width:16)
                let radius : CGFloat = 8
                containerView.layer.cornerRadius = radius
                let iv = UILabel()
                iv.text = randomNumberForLabel(from: 1, to: 10)
                iv.textColor = .white
                iv.textAlignment = .center
                iv.font = UIFont.boldSystemFont(ofSize: 13)
                iv.adjustsFontSizeToFitWidth = true
                iv.setWidth(width: 10)
                iv.setHeight(height: 10)
                containerView.addSubview(iv)
                iv.centerY(inView: containerView)
                iv.centerX(inView: containerView)
                return containerView
            }()
            annotationView2.addSubview(redCircle)
        }
        return annotationView
    }
    
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//      
//            
//    }
    
    //turns off touch annotation
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            view.isEnabled = false
        }
    }
}
