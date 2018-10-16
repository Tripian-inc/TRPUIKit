//
//  TRPCircleMenu.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 28.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation
open class TRPCircleMenu: UIButton {
    public enum CurrentState {
        case open, close
    }
    public enum Position {
        case left, right, top, bottom
    }
    
    fileprivate var animator = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.6)//UIViewPropertyAnimator(duration: 0.1, curve: .easeOut)
    private var subButtons: [TRPCirleButtonPropety] = []
    private var createdSubButtons: [TRPCirleButton] = []
    private var normalIcon: String?
    private var selectedIcon: String?
    private var normalImageView: UIImageView?
    private var selectedImageView: UIImageView?
    private var isNormal: Bool = true
    private var containerView: UIView?
    private var subButtonsPosition: Position = .left
    public var subButtonSpace: CGFloat = 25
    
    private var currentStatus: CurrentState = .close {
        didSet {
            delegate?.circleMenu(self, changedState: currentStatus)
        }
    }
    private var isAnimating = false
    private var cirleR: CGFloat = 40
    public var delegate: TRPCirleMenuDelegate?
    
    
    public init(frame: CGRect,
                normalIcon: String?,
                selectedIcon: String?,
                subButtons: [TRPCirleButtonPropety]?,
                position: Position = .left) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.normalIcon = normalIcon
        self.selectedIcon = selectedIcon
        self.subButtons = subButtons ?? []
        self.subButtonsPosition = position
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(self.onPressed), for: UIControl.Event.touchDown)
        layer.cornerRadius = frame.width / 2
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        if let icon = normalIcon, let image = UIImage(named: icon) {
            normalImageView = UIImageView(image: image)
            addSubview(normalImageView!)
            setCenter(imageView: normalImageView!)
        }
        if let icon = selectedIcon, let image = UIImage(named: icon) {
            selectedImageView = UIImageView(image: image)
            addSubview(selectedImageView!)
            selectedImageView?.alpha = 0
            setCenter(imageView: selectedImageView!)
        }
    }
    
    open override func layoutSubviews() {
        if containerView == nil {
            createContainerView()
            containerView!.alpha = 0
            containerView!.isHidden = true
        }
    }
    
    @objc func onPressed() {
        if isAnimating == true {return}
        tapRotatedAnimation(0.4, isSelected: !self.isSelected)
        if createdSubButtons.count == 0 {
            createSubButtons(subButtons)
        }
        if isSelected {
            containerView!.alpha = 1
            self.containerView!.isHidden = false
        }
        addAnimation()
    }
    
    private func setCenter(imageView: UIImageView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

// MARK: Animation For Main Button
extension TRPCircleMenu {
    fileprivate func tapRotatedAnimation(_ duration: Float, isSelected: Bool) {
        if let customNormalIconView = self.normalImageView {
            animationForImages(customNormalIconView, !isSelected, duration)
        }
        if let customSelectedIconView = self.selectedImageView {
            animationForImages(customSelectedIconView, isSelected, duration)
        }
        
        self.isSelected = isSelected
        alpha = isSelected ? 0.5 : 1
    }
    
    fileprivate func animationForImages(_ view: UIImageView, _ isShow: Bool, _ duration: Float) {
        var toAngle: Float = 180.0
        var fromAngle: Float = 0
        var fromScale = 1.0
        var toScale = 0.2
        var fromOpacity = 1
        var toOpacity = 0
        if isShow == true {
            toAngle = 0
            fromAngle = -180
            fromScale = 0.2
            toScale = 1.0
            fromOpacity = 0
            toOpacity = 1
        }
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnim.duration = TimeInterval(duration)
        rotationAnim.toValue = (toAngle.degrees)
        rotationAnim.fromValue = (fromAngle.degrees)
        rotationAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let fadeAnim = CABasicAnimation(keyPath: "opacity")
        fadeAnim.duration = TimeInterval(duration)
        fadeAnim.fromValue = fromOpacity
        fadeAnim.toValue = toOpacity
        fadeAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        fadeAnim.fillMode = CAMediaTimingFillMode.forwards
        fadeAnim.isRemovedOnCompletion = false
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.duration = TimeInterval(duration)
        scaleAnim.toValue = toScale
        scaleAnim.fromValue = fromScale
        scaleAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(rotationAnim, forKey: nil)
        view.layer.add(fadeAnim, forKey: nil)
        view.layer.add(scaleAnim, forKey: nil)
    }
}

// MARK: Container view
extension TRPCircleMenu {
    
    fileprivate func createContainerView() {
        containerView = UIView(frame: CGRect.zero)
        superview?.insertSubview(containerView!, belowSubview: self)
        containerView!.translatesAutoresizingMaskIntoConstraints = false
        
        var width: CGFloat = 200
        var height: CGFloat = 100
        
        switch subButtonsPosition {
        case .left:
            width = CGFloat(subButtons.count) * CGFloat(40 + subButtonSpace)
            height = frame.height
            containerView!.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            containerView!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            break
        case .right:
            width = CGFloat(subButtons.count) * CGFloat(40 + subButtonSpace)
            height = frame.height
            containerView!.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            containerView!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            break
        case .top:
            height = CGFloat(subButtons.count) * CGFloat(40 + subButtonSpace)
            width = frame.height
            containerView!.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            containerView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            break
        case .bottom:
            height = CGFloat(subButtons.count) * CGFloat(40 + subButtonSpace)
            width = frame.height
            containerView!.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            containerView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            break
        }
        containerView!.widthAnchor.constraint(equalToConstant: width).isActive = true
        containerView!.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
}

// MARK: SubButtons
extension TRPCircleMenu {
    
    fileprivate func createSubButtons(_ buttons: [TRPCirleButtonPropety]) {
        guard let containerView = containerView else {return}
        
        for i in 0..<buttons.count {
            //let startX: CGFloat = (containerView.frame.width - cirleR - subButtonSpace) - ((cirleR + subButtonSpace) * CGFloat(i))
            let startX: CGFloat = self.containerView!.frame.width - 40 - subButtonSpace
            let startY: CGFloat = (containerView.frame.height - cirleR) / 2
            if let image = UIImage(named: buttons[i].iconName) {
                let btn = TRPCirleButton(frame: CGRect(x: startX, y:startY, width: cirleR, height: cirleR),
                                         normalImage:image,
                                         titleName: buttons[i].name)
                btn.alpha = 0
                btn.tag = i
                btn.addTarget(self, action: #selector(subButtonPressed(_:)), for: UIControl.Event.touchDown)
                containerView.addSubview(btn)
                createdSubButtons.append(btn)
            }
        }
        
    }
    
    @objc func subButtonPressed(_ sender: UIButton) {
        delegate?.circleMenu(self, onPress: sender, atIndex: sender.tag)
    }
    
}



extension TRPCircleMenu {
    func addAnimation() {
        isAnimating = true
        animator.addAnimations {
            if self.currentStatus == .close {
                for i in 0..<self.createdSubButtons.count {
                    let position = (self.containerView!.frame.width - 40 - self.subButtonSpace) - ((40 + self.subButtonSpace) * CGFloat(i))
                    self.createdSubButtons[i].transform = CGAffineTransform(translationX: -position, y: 0)
                    self.createdSubButtons[i].alpha = 1
                }
            }else {
                for i in 0..<self.subButtons.count {
                    self.createdSubButtons[i].transform = CGAffineTransform.identity
                    self.createdSubButtons[i].alpha = 0
                }
            }
        }
        animator.addCompletion { _ in
            if self.currentStatus == .close {
                self.currentStatus = .open
            }else {
                self.currentStatus = .close
                self.containerView!.alpha = 0
                self.containerView!.isHidden = true
            }
            self.isAnimating = false
        }
        animator.startAnimation()
    }
}



internal extension Float {
    var radians: Float {
        return self * (Float(180) / Float.pi)
    }
    
    var degrees: Float {
        return self * Float.pi / 180.0
    }
}

internal extension UIView {
    
    var angleZ: Float {
        return atan2(Float(transform.b), Float(transform.a)).radians
    }
}

