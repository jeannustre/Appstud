//
//  Marker.swift
//  Appstud
//
//  Created by Jean Sarda on 17/05/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import GoogleMaps

class Marker: GMSMarker {
    
    // MARK: - Views
    let markerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    let frameView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
    // MARK: Transformation
    let pointerShape = CAShapeLayer()
    let cornersToRound = UIRectCorner.topLeft.union(UIRectCorner.topRight.union(UIRectCorner.bottomRight))
    
    // MARK: - Init
    public override init() {
        super.init()
        
        self.setupMainShape()
        self.setupRoundShapes()
        self.setupColors()
        self.setupViews()
        
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.iconView = markerView
        self.groundAnchor = CGPoint(x: 0, y: 1)
    }
    
    public convenience init(position: CLLocationCoordinate2D) {
        self.init()
        self.position = position
    }
    
    // MARK: - Interface setup
    private func setupColors() {
        markerView.backgroundColor = UIColor(red: 248/255, green: 148/255, blue: 6/255, alpha: 0.5)
        frameView.backgroundColor = UIColor.black
        imageView.backgroundColor = UIColor.white
    }
    
    private func setupMainShape() {
        pointerShape.bounds = markerView.frame
        pointerShape.position = markerView.center
        let pointerRadius = CGSize(width: pointerShape.frame.width / 2, height: pointerShape.frame.width / 2)
        pointerShape.path = UIBezierPath(roundedRect: markerView.frame, byRoundingCorners: cornersToRound, cornerRadii: pointerRadius).cgPath
        markerView.layer.mask = pointerShape
    }
    
    func setupRoundShapes() {
        frameView.layer.cornerRadius = frameView.frame.width / 2
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    private func setupViews() {
        imageView.center = frameView.center
        frameView.addSubview(imageView)
        markerView.addSubview(frameView)
    }
    
}
