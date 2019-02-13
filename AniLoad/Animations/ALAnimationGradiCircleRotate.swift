//
//  ALAnimationBallRotate.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

class ALAnimationGradiCircleRotate: ALAnimationDelegate {
    
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor) {
        let duration: CFTimeInterval = 0.9
        // Animation
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.keyTimes = [0, 0.2, 1]
        animation.values = [0, 0, 2 * Double.pi]
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        // Draw circles
        
        let circle = ALShape.gradiCircle.layerWith(size: size, color: color)
        let frame = CGRect(
            x: (layer.bounds.width - size.width) / 2,
            y: (layer.bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        
        circle.frame = frame
        circle.add(animation, forKey: "animation")
        circle.masksToBounds = true
        layer.addSublayer(circle)
    }
    
}


