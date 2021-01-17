//
//  SquareAnnotation.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 17.01.2021.
//

import MapKit


class SquareAnnotation : NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D){
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
}
