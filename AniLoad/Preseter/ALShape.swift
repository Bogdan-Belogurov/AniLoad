//
//  ALShape.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

enum ALShape {
    
    case gradiCircle
    
    func layerWith(size: CGSize, color: UIColor) -> CALayer {
        let layer: CAShapeLayer = CAShapeLayer()
        var path: UIBezierPath = UIBezierPath()
        let lineWidth: CGFloat = 2
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        switch self {
        case .gradiCircle:
            layer.backgroundColor = nil
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.type = .conic

            gradientLayer.colors = [color.withAlphaComponent(0).cgColor, color.withAlphaComponent(0.25).cgColor, color.withAlphaComponent(0.5).cgColor, color.withAlphaComponent(0.75).cgColor, color.withAlphaComponent(1).cgColor]
            gradientLayer.locations = [NSNumber(value: 0.0), NSNumber(value: 0.25), NSNumber(value: 0.5), NSNumber(value: 0.75), NSNumber(value: 1)]
            gradientLayer.frame = layer.frame
            gradientLayer.cornerRadius = size.width/2
            layer.addSublayer(gradientLayer)
        }
        
        
        return layer
    }
}

