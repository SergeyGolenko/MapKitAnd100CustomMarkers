//
//  ViewController.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 15.01.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - Actions
    
    
    //MARK: - Properties
    var pin : MKAnnotation!
   
  
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
    
//    func addAnnotation(){
//        annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeCoordinate, longitude: longitudeCoordinate)
//        annotation.title = "Ukraine"
//        annotation.subtitle = "my small Ukraine"
//        mapView.addAnnotation(annotation)
//    }
//
   
    
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
            annotation.coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(randomBetweenNumbers(firstNum: 46, secondNum: 52)), longitude: CLLocationDegrees(randomBetweenNumbers(firstNum:23, secondNum: 39)))
            let randomTitleNumber = Int.random(in: 1...100)
            annotation.title = "\(randomTitleNumber)"
            annotation.subtitle = "\(annotation.coordinate.longitude)"
            mapView.addAnnotation(annotation)
        }
        
        

    }
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadCoordinateUkraine()
        generateAnnoLoc()
    }
}

extension ViewController : MKMapViewDelegate {
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        
        let annotationIdentifier = "AnnotationIdentifier"
        
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
           let passwordContainerView : UIView = {
                   let containerView = UIView()
                   containerView.backgroundColor = .red
            containerView.setHeight(height:annotationView2.bounds.height)
            containerView.setWidth(width: annotationView2.bounds.width)
            
            
            let iv = UILabel()
            iv.backgroundColor = .yellow
            iv.text = "IOS"
                   //iv.centerY(inView: containerView)
            iv.setWidth(width: 30)
            iv.setHeight(height: 30)
            
           
            containerView.addSubview(iv)
            iv.centerY(inView: containerView)
            iv.centerX(inView: containerView)
           
                   return containerView
               }()
            annotationView2.addSubview(passwordContainerView)
        }
        return annotationView
    }
    
}
