//
//  File.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

/**
 *  UIViewController conforms this protocol to be able to display NVActivityIndicatorView as UI blocker.
 *
 *  This extends abilities of UIViewController to display and remove UI blocker.
 */
public protocol ALViewable {}

public extension ALViewable where Self: UIViewController {
    
    /// Current status of animation, read-only.
    var isAnimating: Bool { return ALPresenter.sharedInstance.isAnimating }
    
    /**
     Display UI blocker.
     
     Appropriate ALView.DEFAULT_* values are used for omitted params.
     
     - parameter size:                 size of activity indicator view.
     - parameter message:              message displayed under activity indicator view.
     - parameter messageFont:          font of message displayed under activity indicator view.
     - parameter type:                 animation type.
     - parameter color:                color of activity indicator view.
     - parameter padding:              padding of activity indicator view.
     - parameter displayTimeThreshold: display time threshold to actually display UI blocker.
     - parameter minimumDisplayTime:   minimum display time of UI blocker.
     - parameter fadeInAnimation:      fade in animation.
     */
    public func startAnimating(
        _ size: CGSize? = nil,
        message: String? = nil,
        messageFont: UIFont? = nil,
        type: ALType? = nil,
        color: UIColor? = nil,
        padding: CGFloat? = nil,
        displayTimeThreshold: Int? = nil,
        minimumDisplayTime: Int? = nil,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil,
        fadeInAnimation: FadeInAnimation? = ALView.DEFAULT_FADE_IN_ANIMATION) {
        let activityData = ActivityData(size: size,
                                        message: message,
                                        messageFont: messageFont,
                                        type: type,
                                        color: color,
                                        padding: padding,
                                        displayTimeThreshold: displayTimeThreshold,
                                        minimumDisplayTime: minimumDisplayTime,
                                        backgroundColor: backgroundColor,
                                        textColor: textColor)
        
        ALPresenter.sharedInstance.startAnimating(activityData, fadeInAnimation)
    }
    
    /**
     Remove UI blocker.
     
     - parameter fadeOutAnimation: fade out animation.
     */
    public func stopAnimating(_ fadeOutAnimation: FadeOutAnimation? = ALView.DEFAULT_FADE_OUT_ANIMATION) {
        ALPresenter.sharedInstance.stopAnimating(fadeOutAnimation)
    }
}
