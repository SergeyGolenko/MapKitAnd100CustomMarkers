//
//  ClusterAnnotationView.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 19.01.2021.
//

import UIKit
import MapKit

final class ClusterAnnotationView: MKAnnotationView {
    
    func textForCluster() -> String{
        let t = String(Int.random(in: 1..<11))
        return t
    }
    
    func middleText(annotationHere: MKClusterAnnotation) -> String? {
        let t = annotationHere.memberAnnotations.count
        let br = String(t)
        return br
    }
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster2 = annotation as? MKClusterAnnotation else { return }
            displayPriority = .defaultLow
            let redCircle : UIView = {
                let containerView = UIView()
                containerView.backgroundColor = .black
                containerView.setHeight(height:16)
                containerView.setWidth(width:16)
                let radius : CGFloat = 8
                containerView.layer.cornerRadius = radius
                let iv = UILabel()
                iv.text = middleText(annotationHere: cluster2)
                iv.textColor = .white
                iv.textAlignment = .center
                iv.font = UIFont.boldSystemFont(ofSize: 13)
                iv.adjustsFontSizeToFitWidth = true
                iv.setWidth(width: 20)
                iv.setHeight(height: 20)
                containerView.addSubview(iv)
                iv.centerY(inView: containerView)
                iv.centerX(inView: containerView)
                return containerView
            }()
            
            self.addSubview(redCircle)
        }
    }
}

