//
//  ALView.swift
//  AniLoad
//
//  Created by Bogdan Belogurov on 12/02/2019.
//  Copyright © 2019 Bogdan Belogurov. All rights reserved.
//

import UIKit

public enum ALType: CaseIterable {

    case rotate
    
    func animation() -> ALAnimationDelegate {
        switch self {
        case .rotate:
            return ALAnimationGradiCircleRotate()
        }
    }
}

/// Function that performs fade in/out animation.
public typealias FadeInAnimation = (UIView) -> Void

/// Function that performs fade out animation.
///
/// - Note: Must call the second parameter on the animation completion.
public typealias FadeOutAnimation = (UIView, @escaping () -> Void) -> Void

public final class ALView: UIView {
    
    public static var DEFAULT_TYPE: ALType = .rotate
    
    /// Default color of activity indicator. Default value is UIColor.white.
    public static var DEFAULT_COLOR = UIColor.white
    
    /// Default color of text. Default value is UIColor.white.
    public static var DEFAULT_TEXT_COLOR = UIColor.white
    
    /// Default padding. Default value is 0.
    public static var DEFAULT_PADDING: CGFloat = 0
    
    /// Default size of activity indicator view in UI blocker. Default value is 60x60.
    public static var DEFAULT_BLOCKER_SIZE = CGSize(width: 60, height: 60)
    
    /// Default display time threshold to actually display UI blocker. Default value is 0 ms.
    ///
    /// - note:
    /// Default time that has to be elapsed (between calls of `startAnimating()` and `stopAnimating()`) in order to actually display UI blocker. It should be set thinking about what the minimum duration of an activity is to be worth showing it to the user. If the activity ends before this time threshold, then it will not be displayed at all.
    public static var DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD = 0
    
    /// Default minimum display time of UI blocker. Default value is 0 ms.
    ///
    /// - note:
    /// Default minimum display time of UI blocker. Its main purpose is to avoid flashes showing and hiding it so fast. For instance, setting it to 200ms will force UI blocker to be shown for at least this time (regardless of calling `stopAnimating()` ealier).
    public static var DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 0
    
    /// Default message displayed in UI blocker. Default value is nil.
    public static var DEFAULT_BLOCKER_MESSAGE: String?
    
    /// Default message spacing to activity indicator view in UI blocker. Default value is 8.
    public static var DEFAULT_BLOCKER_MESSAGE_SPACING = CGFloat(8.0)
    
    /// Default font of message displayed in UI blocker. Default value is bold system font, size 20.
    public static var DEFAULT_BLOCKER_MESSAGE_FONT = UIFont.boldSystemFont(ofSize: 20)
    
    /// Default background color of UI blocker. Default value is UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    public static var DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    /// Default fade in animation.
    public static var DEFAULT_FADE_IN_ANIMATION: FadeInAnimation = { view in
        view.alpha = 0
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1
        }
    }
    
    /// Default fade out animation.
    public static var DEFAULT_FADE_OUT_ANIMATION: FadeOutAnimation = { (view, complete) in
        UIView.animate(withDuration: 0.25,
                       animations: {
                        view.alpha = 0
        },
                       completion: { completed in
                        if completed {
                            complete()
                        }
        })
    }
    
    /// Animation type.
    public var type: ALType = ALView.DEFAULT_TYPE
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var typeName: String {
        get {
            return getTypeName()
        }
        set {
            _setTypeName(newValue)
        }
    }
    
    /// Color of activity indicator view.
    @IBInspectable public var color: UIColor = ALView.DEFAULT_COLOR
    
    /// Padding of activity indicator view.
    @IBInspectable public var padding: CGFloat = ALView.DEFAULT_PADDING
    
    /// Current status of animation, read-only.
    @available(*, deprecated: 3.1)
    public var animating: Bool { return isAnimating }
    
    /// Current status of animation, read-only.
    private(set) public var isAnimating: Bool = false
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        isHidden = true
    }
    /**
     Create a activity indicator view.
     
     Appropriate ALView.DEFAULT_* values are used for omitted params.
     
     - parameter frame:   view's frame.
     - parameter type:    animation type.
     - parameter color:   color of activity indicator view.
     - parameter padding: padding of activity indicator view.
     
     - returns: The activity indicator view.
     */
    
    public init(frame: CGRect, type: ALType? = nil, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.type = type ?? ALView.DEFAULT_TYPE
        self.color = color ?? ALView.DEFAULT_COLOR
        self.padding = padding ?? ALView.DEFAULT_PADDING
        super.init(frame: frame)
        isHidden = true
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }
    
    public override var bounds: CGRect {
        didSet {
            // setup the animation again for the new bounds
            if oldValue != bounds && isAnimating {
                setUpAnimation()
            }
        }
    }
    
    /**
     Start animating.
     */
    public final func startAnimating() {
        guard !isAnimating else {
            return
        }
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }
    
    /**
     Stop animating.
     */
    public final func stopAnimating() {
        guard isAnimating else {
            return
        }
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }
    
    // MARK: Internal
    
    // swiftlint:disable:next identifier_name
    func _setTypeName(_ typeName: String) {
        for item in ALType.allCases {
            if String(describing: item).caseInsensitiveCompare(typeName) == ComparisonResult.orderedSame {
                type = item
                break
            }
        }
    }
    
    func getTypeName() -> String {
        return String(describing: type)
    }
    
    // MARK: Privates
    private final func setUpAnimation() {
        let animation: ALAnimationDelegate = type.animation()
        #if swift(>=4.2)
        var animationRect = frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        #else
        var animationRect = UIEdgeInsetsInsetRect(frame, UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        #endif
        let minEdge = min(animationRect.width, animationRect.height)
        
        layer.sublayers = nil
        animationRect.size = CGSize(width: minEdge, height: minEdge)
        animation.setUpAnimation(in: layer, size: animationRect.size, color: color)
    }
}
