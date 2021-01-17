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
    
    
    @IBAction func check(_ sender: Any) {
        
        for i in arrayAnnotation {
            i.isUserInteractionEnabled = false
            
        }
        
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        
        let annotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
        mapView.removeAnnotations(annotations)
        print(arrayAnnotation.count)
        arrayAnnotation.removeAll()
        generateAnnoLoc()
        
        
    }
    
    //MARK: - Properties
    let latitudeCoordinate = CLLocationDegrees(49.22)
    let longitudeCoordinate = CLLocationDegrees(31.10)
    var arrayAnnotation : [MKAnnotationView] = []
   

    
    //MARK: - Functions
    func createCenterAnnotation(){
        let pin = SquareAnnotation(title: "Center Ukraine", subtitle: "center", coordinate: CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate))
            mapView.addAnnotation(pin)
    }
    
    func randomNumberForLabel(from:Int,to:Int) -> String{
        let number = Int.random(in: from...to)
        return String(number)
    }
    
    func loadCoordinateUkraine(){
        let locationCoordinate2D = CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate)
        let longitudeUkraine = CLLocationDistance(131_600_0)
        let latitudeUkraine = CLLocationDistance(750_000)
        let centerUkraine = MKCoordinateRegion(center: locationCoordinate2D, latitudinalMeters: latitudeUkraine, longitudinalMeters:longitudeUkraine)
        mapView.setRegion(centerUkraine, animated: true)
    }
    
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func generateAnnoLoc() {
        var num = 0
        //First we declare While to repeat adding Annotation
        while num != 100 {
                num += 1
            //Add Annotation
            let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(self.randomBetweenNumbers(firstNum: 46, secondNum: 52)), longitude: CLLocationDegrees(self.randomBetweenNumbers(firstNum:23, secondNum: 39)))
                let randomTitleNumber = Int.random(in: 1...100)
            //annotation.title = String(Int(annotation.coordinate.latitude))
                self.mapView.addAnnotation(annotation)
        }
        
    }
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadCoordinateUkraine()
        generateAnnoLoc()
        createCenterAnnotation()
    }
}

extension MapViewController : MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is SquareAnnotation else {return nil}
        let annotationIdentifier = "circle"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
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
            arrayAnnotation.append(annotationView2)
        }
        return annotationView
    }
    
    
    // отключает прикосновение к annotation
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for view in views {
            view.isEnabled = true
        }
    }
    
    
    
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//
//
//    }
    

    

}
