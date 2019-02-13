//
//  ViewController.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    private let presentingIndicatorType = {
        return ALType.rotate
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1)
        let frame = CGRect(x:self.view.frame.width/2 - 50, y: self.view.frame.height/2 - 50, width: 100, height: 100)
        let activityIndicatorView = ALView(frame: frame, type: presentingIndicatorType, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), padding: 20)
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()

    }


}

