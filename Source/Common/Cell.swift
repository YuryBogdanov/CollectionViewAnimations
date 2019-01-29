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

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        label = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = UIColor.white

            return label
        }()

        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.center.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        UIView.performWithoutAnimation {
            self.contentView.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if contentView.layer.mask == nil {
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath.pathForOutgoingMessage(rect: contentView.bounds).cgPath
            contentView.layer.mask = maskLayer
        } else if let maskLayer = contentView.layer.mask as? CAShapeLayer {
            guard maskLayer.bounds != bounds else { return }
//            CATransaction.begin()
//            CATransaction.setAnimationDuration(0.17)
//            maskLayer.bounds = CGRect(x: -bounds.width / 2, y: -bounds.height / 2, width: bounds.width, height: bounds.height)
//            CATransaction.commit()
            let newBounds = CGRect(x: -bounds.width / 2, y: -bounds.height / 2, width: bounds.width, height: bounds.height)
            let animation = CABasicAnimation(keyPath: "bounds.size")
            animation.duration = 0.17
            animation.fromValue = maskLayer.bounds
            animation.toValue = newBounds
            maskLayer.add(animation, forKey: "bounds")
            CATransaction.begin()
            maskLayer.bounds = newBounds
            CATransaction.commit()
        }
    }

    // MARK: Layout

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layoutIfNeeded()
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
