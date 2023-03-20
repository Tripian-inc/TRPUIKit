//
//  TRPLoaderView.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 27.09.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import Foundation

public class TRPLoaderView: UIView {
    var loaderView: Loader?
    let superView: UIView
    var isAdded = false
    public var loadingImage: UIImage?
    
    public init(superView: UIView) {
        self.superView = superView
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(forLong: Bool = false) {
        if isAdded == true {return}
        
        let widht: CGFloat = forLong ? UIScreen.main.bounds.width : 70
        let height: CGFloat = forLong ? UIScreen.main.bounds.height : 70
        let x: CGFloat = forLong ? 0 : (superView.frame.width - widht) / 2
        let y: CGFloat = forLong ? 0 : (superView.frame.height - height) / 2
        loaderView = Loader(frame: CGRect(x: x,
                                          y: y,
                                          width: widht,
                                          height: height), loadingImage: loadingImage, isLong: forLong)
//        loaderView?.loadingImage = loadingImage
        superView.addSubview(loaderView!)
        isAdded = true
    }
    
    public func remove() {
        if isAdded == false {return}
        if loaderView != nil {
            loaderView!.removeFromSuperview()
        }
        isAdded = false
    }
}

