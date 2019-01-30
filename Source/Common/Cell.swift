//
//  Cell.swift
//  CollectionViewAnimations
//
//  Created by Christian Noon on 10/29/15.
//  Copyright © 2015 Noondev. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    class var reuseIdentifier: String { return "\(self)" }
    class var kind: String { return "ContentCell" }

    var label: UILabel!
    lazy var backView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    var triangle = MessagePointerView()
    var hideTheCornerView = UIView()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        label = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = UIColor.white

            return label
        }()
        contentView.addSubview(backView)
        contentView.addSubview(triangle)
        contentView.addSubview(hideTheCornerView)
        backView.addSubview(label)
        backView.layer.cornerRadius = 17
        backView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-7)
        }
        triangle.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(7)
            make.height.equalTo(9)
        }
        hideTheCornerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalTo(triangle.snp.left)
            make.height.equalTo(17)
            make.width.equalTo(17)
        }
        label.snp.makeConstraints { make in
            make.center.equalTo(backView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        UIView.performWithoutAnimation {
            self.backgroundColor = nil
        }
    }

    // MARK: Layout

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            mask.fillColor = UIColor.red.cgColor
            self.layer.mask = mask
        }
    }
}


// MARK: -

class SectionHeaderCell: UICollectionReusableView {
    class var reuseIdentifier: String { return "\(self)" }
    class var kind: String { return "SectionHeaderCell" }

    var label: UILabel!

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(white: 0.2, alpha: 1.0)

        label = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.textColor = UIColor.white

            return label
        }()

        addSubview(label)

        label.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: Layout

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
    }
}
