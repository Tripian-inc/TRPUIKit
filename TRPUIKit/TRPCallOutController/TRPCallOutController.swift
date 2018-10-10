//
//  TRPCallOutController.swift
//  TRPUIKit
//
//  Created by Evren Yaşar on 1.10.2018.
//  Copyright © 2018 Evren Yaşar. All rights reserved.
//

import UIKit
public struct CallOutCellMode {
    var id:Int
    var name: String
    var poiCategory:String
    var imageLink: String
    var startCount: Float
    var reviewCount: Int
    var price: Int
    
    public init(id: Int, name: String, poiCategory: String, imageLink: String, startCount: Float, reviewCount: Int, price: Int) {
        self.id = id
        self.name = name
        self.poiCategory = poiCategory
        self.imageLink = imageLink
        self.startCount = startCount
        self.reviewCount = reviewCount
        self.price = price
    }
}

public class TRPCallOutController {
    let transformY: CGFloat = 140
    let parentView: UIView;
    var cell: TRPCallOutCell?;
    public var isOpen = false
    public var isAnimating = false
    public var cellPressed: ((_ id: Int)-> Void)? = nil
    
    
    public init(inView: UIView) {
        parentView = inView
        commonInit()
    }
    
    private func commonInit() {
        cell = TRPCallOutCell()
        parentView.addSubview(cell!)
        cell!.translatesAutoresizingMaskIntoConstraints = false
        cell!.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 32).isActive = true
        cell!.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -32).isActive = true
        cell!.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -32).isActive = true
        cell?.transform = CGAffineTransform(translationX: 0, y: self.transformY)
        cell?.cellPressed = { id in
            self.cellPressed?(id)
        }
    }
    
    public func show(model: CallOutCellMode){
        showAnimation()
        cell?.updateModel(model)
    }
    
    public func hidden() {
        if cell == nil {return}
        hiddenAnimation()
    }
    private func showAnimation() {
        cell?.transform = CGAffineTransform(translationX: 0, y: transformY)
        UIView.animate(withDuration: 0.2, delay:0, options: .curveEaseOut, animations: {
            self.cell?.transform = CGAffineTransform.identity
        }) { (_) in
            self.cell?.transform = CGAffineTransform.identity
        }
    }
    
    private func hiddenAnimation() {
        UIView.animate(withDuration: 0.2, delay:0, options: .curveEaseIn, animations: {
            self.cell?.transform = CGAffineTransform(translationX: 0, y: self.transformY)
        }) { (_) in
            self.cell?.transform = CGAffineTransform(translationX: 0, y: self.transformY)
        }
    }
}



class TRPCallOutCell: UIView {
    
    private let imageView: UIView = {
        let img = UIImageView()
        img.backgroundColor = TRPColor.darkGrey
        img.layer.cornerRadius = 64 / 2
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = TRPColor.darkGrey
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "asdasda asdasda asdasda asdasda asdasda asdasda asdasda asdasda asdasda"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = TRPColor.darkGrey
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = TRPColor.darkGrey
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Restaurant"
        label.numberOfLines = 1
        return label
    }()
    
    private let padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private var model: CallOutCellMode?
    public var cellPressed: ((_ id: Int) -> Void)? = nil
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let stackView   = UIStackView()
    let star = TRPStar(frame: CGRect(x: 0, y: 0, width: 100, height: 12))
    
    public func updateModel(_ model : CallOutCellMode){
        self.model = model
        priceLabel.text = String(repeating: "$" , count: model.price)
        titleLabel.text = model.name
        typeLabel.text = model.poiCategory
        if Int(model.startCount) < 1 {
            star.isHidden = true
        }else {
            star.isHidden = false
            star.setRating(Int(model.startCount))
        }
        
    }
    
    private func commonInit() {
        layoutIfNeeded()
        backgroundColor = UIColor.white
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        heightAnchor.constraint(equalToConstant: 64 + padding.top + padding.bottom).isActive = true
        addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        addSubview(priceLabel)
        priceLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * padding.right).isActive = true
        priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        stackView.axis  = UILayoutConstraintAxis.vertical
        stackView.distribution  = UIStackViewDistribution.fill
        stackView.alignment = UIStackViewAlignment.leading
        stackView.spacing   = 6.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(star)
        star.show()
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressed))
        addGestureRecognizer(tap)
    }
    
    @objc func pressed() -> Void {
        print("Pressed");
        if let id = model?.id {
            cellPressed?(id)
        }
    }
    
}
