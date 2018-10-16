//
//  TRPSearchAreaButton.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 10.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import UIKit
public class TRPSearchAreaButton: UIButton {
    
    private var animator = UIViewPropertyAnimator()
    public var title:String?
    public var titleColor: UIColor = UIColor.black {
        didSet {
            setTitleColor(titleColor, for: UIControl.State.normal)
        }
    }
    public var fontSize: CGFloat = 12 {
        didSet {
            titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
    public var cornerRadius : CGFloat = 14 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public var shadowColor: UIColor = UIColor.black{
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    public var shadowRadius: CGFloat = 2 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    public var shadowOpacity: Float = 0.2 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    public var shadownOffset: CGSize = CGSize(width: 1, height: 1) {
        didSet {
            layer.shadowOffset = shadownOffset
        }
    }
    
    public var isAnimating = false
    public var isOpen: Bool = false
    public var zoomLevelTrashHold: Double = 12.4
    
    public init(frame: CGRect, title:String) {
        super.init(frame: frame)
        self.title = title
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = UIColor.red
        layer.cornerRadius = cornerRadius
        alpha = 0
        transform = CGAffineTransform(scaleX: 0, y: 0)
        setTitle(title ?? "", for: UIControl.State.normal)
        setTitleColor(titleColor, for: UIControl.State.normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadownOffset
        //self.alpha = 0
        //self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    
    public func show() {
        if isAnimating == true || isOpen == true {return}
        isAnimating = true
        
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        animator = UIViewPropertyAnimator(duration: 0.1, curve: UIView.AnimationCurve.easeOut, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        })
        animator.addCompletion { _ in
            self.alpha = 1
            self.transform = CGAffineTransform.identity
            self.isAnimating = false
            self.isOpen = true
        }
        animator.startAnimation()
    }
    
    public func hidden() {
        if isAnimating == true {return}
        isAnimating = true
        animator = UIViewPropertyAnimator(duration: 0.1, curve: UIView.AnimationCurve.easeOut, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        })
        animator.addCompletion { _ in
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.isAnimating = false
            self.isOpen = false
        }
        animator.startAnimation()
    }
    
    public func zoomLevel(_ level: Double) {
        if level > zoomLevelTrashHold {
            if isOpen == false {
                show()
            }
        }else {
            if isOpen == true {
                hidden()
            }
        }
    }
    
}
