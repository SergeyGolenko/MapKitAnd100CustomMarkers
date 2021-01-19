//
//  CircleAnnotation.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 17.01.2021.
//

import MapKit

 final class CircleAnnotation : NSObject, MKAnnotation {
   
    let coordinate: CLLocationCoordinate2D
    
    init(coordinate:CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
    
}
