//
//  TRPLoaderVC.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 27.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import UIKit
public class TRPLoaderVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = UIScreen.main.bounds
        self.view.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0.1)
        //self.view.addSubview(contentView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        let window: UIWindow = UIApplication.shared.keyWindow!
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        let widht: CGFloat = 100
        let height: CGFloat = 40
        let loader = Loader(frame: CGRect(x: (view.frame.width - widht) / 2, y: (view.frame.height - height) / 3, width: widht, height: height))
        view.addSubview(loader)
    }
    
}

