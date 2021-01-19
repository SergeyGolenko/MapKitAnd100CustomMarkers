//
//  CircleAnnotationView.swift
//  MapKitAnd100CustomMarkers
//
//  Created by Сергей Голенко on 18.01.2021.
//

import MapKit

final class CircleAnnotationView : MKAnnotationView {
    
    var textLabel2 = "5"
    let textLabel : String = {
        let number = Int.random(in: 1...10)
        return String(number)
    }()
    
    override var annotation: MKAnnotation? {
        
        didSet {
            guard let mapItem = annotation as? CircleAnnotation else { return }
                        
            clusteringIdentifier = "ID"
          // image = UIImage(named: "fire")
            let redCircle : UIView = {
                let containerView = UIView()
                containerView.backgroundColor = .red
                containerView.setHeight(height:16)
                containerView.setWidth(width:16)
                let radius : CGFloat = 8
                containerView.layer.cornerRadius = radius
                let iv = UILabel()
                
                iv.text = textLabel
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
            
            self.addSubview(redCircle)
          
           

        }
    }
}
