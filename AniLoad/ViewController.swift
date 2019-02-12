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
        let frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        let activityIndicatorView = ALView(frame: frame, type: presentingIndicatorType)
        activityIndicatorView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        activityIndicatorView.padding = 20
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()

    }


}

