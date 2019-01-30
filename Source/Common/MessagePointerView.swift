//
//  MessagePointerView.swift
//  Cell Animations
//
//  Created by Yury Bogdanov on 30/01/2019.
//  Copyright © 2019 Noondev. All rights reserved.
//

import UIKit

final class MessagePointerView: UIView {

    private enum Constants {
        static let radius: CGFloat = 1
        static let pointerWidth: CGFloat = 7
        static let pointerHeight: CGFloat = 9
    }
    
    private var maskLayer: CAShapeLayer {
        if let maskLayer = layer.mask as? CAShapeLayer {
            return maskLayer
        }
        let maskLayer = CAShapeLayer()
        layer.mask = maskLayer
        return maskLayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutMask()
    }

    private func layoutMask() {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: .zero)
        trianglePath.addLine(to: CGPoint(x: bounds.maxX - Constants.radius / 2, y: bounds.maxY - Constants.radius * 2))
        trianglePath.addArc(withCenter: CGPoint(x: bounds.maxX - Constants.radius, y: bounds.maxY - Constants.radius),
                    radius: Constants.radius,
                    startAngle: -CGFloat.pi / 6,
                    endAngle: CGFloat.pi / 2,
                    clockwise: true)
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        trianglePath.close()
        
        maskLayer.path = trianglePath.cgPath
    }
}
