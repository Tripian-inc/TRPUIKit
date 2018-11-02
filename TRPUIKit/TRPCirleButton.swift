//
//  TRPCirleButton.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 4.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import UIKit
public class TRPCirleButton: UIButton {
    
    //    private lazy var imgView : UIImageView = {
    //        let img = UIImageView()
    //        img.translatesAutoresizingMaskIntoConstraints = false
    //        img.contentMode = .center
    //        return img
    //    }()
    
    public var textFontSize: CGFloat = 10 {
        didSet {
            titleLbl.font = UIFont.systemFont(ofSize: textFontSize)
        }
    }
    
    public var textColor: UIColor = UIColor.black {
        didSet{
            titleLbl.textColor = textColor
        }
    }
    
    public var normalBg: UIColor = UIColor.white {
        didSet {
            self.backgroundColor = normalBg
        }
    }
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: textFontSize)
        lbl.textColor = textColor
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    var normalImage: UIImage?
    var selectedImage: UIImage?
    var titleName: String?
    
    public init(frame:CGRect,
         normalImage: UIImage,
         selectedImage: UIImage? = nil,
         titleName: String? = nil) {
        super.init(frame: frame)
        self.normalImage = normalImage
        self.selectedImage = selectedImage
        self.titleName = titleName
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        // addSubview(imgView)
        addSubview(titleLbl)
        backgroundColor = normalBg
        if let titleName = titleName {
            titleLbl.text = titleName
        }
        
        setImage(normalImage, for: .normal)
        if let selected = selectedImage {
            setImage(selected, for: .selected)
        }
        
        titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLbl.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 20).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -10).isActive = true
        titleLbl.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 6).isActive = true
        
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        addTarget(self, action: #selector(onPressed), for: UIControl.Event.touchUpInside)
    }
    
    @objc func onPressed() {
        isSelected = !isSelected
    }
}
