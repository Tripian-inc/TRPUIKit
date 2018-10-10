//
//  TRPMessage.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 19.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import UIKit
public class TRPMessage {
    
    public enum MessageType {
        case success, error, warning, info
        
        func color() -> UIColor {
            switch self {
            case .info:
                return TRPColor.infoMessageColor
            case .error:
                return TRPColor.errorMessageColor
            case .warning:
                return TRPColor.warningMessageColor
            case .success:
                return TRPColor.successMessageColor
            }
        }
    }
    
    public enum Position {
        case top, bottom
    }
    
    private var parentView: UIView {
        get {
            return parentInView != nil ? parentInView! : UIApplication.shared.keyWindow!
        }
    }
    
    private var textLabel: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    private var autoClose = true
    private let position: Position
    private let messageType: MessageType
    private var containerView = UIView()
    private var contentText: String
    private var autoCloseTime: TimeInterval = 0
    private var parentInView: UIView?
    private var height: CGFloat = 50;
    public var onPressed: ((_ view: TRPMessage) -> Void)?
    
    public init(contentText:String,
         type: MessageType,
         position: Position = .top,
         autoClose: Bool = true,
         closeTime: TimeInterval = 2,
         height: CGFloat = 50.0) {
        
        self.contentText = contentText
        self.position = position
        self.messageType = type
        self.autoClose = autoClose
        self.autoCloseTime = closeTime
        self.height = height
        commonInit()
        
    }
    
    public init(contentText:String,
         type: MessageType,
         position: Position = .top,
         autoClose: Bool = true,
         closeTime: TimeInterval = 2,
         height: CGFloat = 50.0,
         inView: UIView) {
        
        self.contentText = contentText
        self.position = position
        self.messageType = type
        self.autoClose = autoClose
        self.autoCloseTime = closeTime
        self.parentInView = inView
        self.height = height
        commonInit()
    }
    
    private func commonInit() {
        containerView = UIView(frame: calculateRect(postion: position))
        containerView.backgroundColor = messageType.color()
        parentView.addSubview(containerView)
        parentView.bringSubview(toFront: containerView)
        containerView.addSubview(textLabel)
        textLabel.text = contentText
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
        containerView.transform = CGAffineTransform(translationX: 0, y: -height)
        containerView.alpha = 0.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewPressed))
        containerView.addGestureRecognizer(tap)
    }
    
    public func show() {
        startAnimation()
        setAutoClose(autoClose)
        print("SHOW -- SHOW -- SHOW")
    }
    
    private func calculateRect(postion: Position) -> CGRect {
        let frame = parentView.frame
        var startY: CGFloat = 0
        
        if position == .top {
            startY = frame.origin.y
        }else if position == .bottom{
            startY = frame.height - height
        }
        
        let rect = CGRect(x: 0, y: startY, width: frame.width, height: height)
        
        return rect
    }
    
    private func setAutoClose(_ status:Bool) {
        if status == false { return }
        Timer.scheduledTimer(withTimeInterval: autoCloseTime, repeats: false) { (_) in
            
            self.closeView()
        }
    }
    
    private func startAnimation() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: -height)
        self.containerView.alpha = 0.3
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let strong = self else {return}
            strong.containerView.transform = CGAffineTransform.identity
            strong.containerView.alpha = 1
        }) { [weak self] (_) in
            guard let strong = self else {return}
            strong.containerView.transform = CGAffineTransform.identity
            strong.containerView.alpha = 1
        }
    }
    
    // TODO: posisyona göre animasyon konumu eklenecek
    private func closeView() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let strong = self else {return}
            strong.containerView.transform = CGAffineTransform(translationX: 0, y: -1 * strong.height)
            strong.containerView.alpha = 0.3
        }) { (_) in
           // guard let strong = self else {return}
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -1 * self.height)
            self.containerView.alpha = 0
            self.containerView.removeFromSuperview()
        }
    }
    
    @objc func viewPressed() {
        onPressed?(self)
    }
}
