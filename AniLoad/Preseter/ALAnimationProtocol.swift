//
//  ALAnimationDelegate.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

protocol ALAnimationDelegate {
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor)
}
