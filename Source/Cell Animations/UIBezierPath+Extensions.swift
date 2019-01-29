//
//  UIBezierPath+Extensions.swift
//  Cell Animations
//
//  Created by y.bogdanov on 29/01/2019.
//  Copyright © 2019 Noondev. All rights reserved.
//

import Foundation
import UIKit

public struct RectCorners {
    public let topRight: CGFloat
    public let bottomRight: CGFloat
    public let bottomLeft: CGFloat
    public let topLeft: CGFloat
}

public extension RectCorners {
    public static func corners(isOutgoing: Bool, isGroupedWithPrevious: Bool) -> RectCorners {
        let pt18: CGFloat = 18
        let pt2: CGFloat = 2
        return isOutgoing
            ? RectCorners(topRight: isGroupedWithPrevious ? pt2 : pt18, bottomRight: pt2, bottomLeft: pt18, topLeft: pt18)
            : RectCorners(topRight: pt18, bottomRight: pt18, bottomLeft: pt2, topLeft: isGroupedWithPrevious ? pt2 : pt18)
    }
    
    public static func corners() -> RectCorners {
        return RectCorners(topRight: 17, bottomRight: 17, bottomLeft: 17, topLeft: 17)
    }
}

extension UIBezierPath {
    private enum Constants {
        static let pointerWidth: CGFloat = 6
        static let pointerHeight: CGFloat = 9
        static let radius: CGFloat = 1
    }
    
    static func pathForOutgoingMessage(rect: CGRect) -> UIBezierPath {
        let corners = RectCorners(topRight: 17, bottomRight: 17, bottomLeft: 17, topLeft: 17)
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: rect.maxX - corners.topRight - Constants.pointerWidth,
                              y: rect.minY))
        if corners.topRight > 0 {
            let center = CGPoint(x: rect.maxX - corners.topRight - Constants.pointerWidth, y: rect.minY + corners.topRight)
            path.addArc(withCenter: center, radius: corners.topRight, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        }
        path.addLine(to: CGPoint(x: rect.maxX - Constants.pointerWidth, y: rect.maxY - Constants.pointerHeight))
        path.addLine(to: CGPoint(x: rect.maxX - Constants.radius / 2, y: rect.maxY - Constants.radius * 2))
        path.addArc(withCenter: CGPoint(x: rect.maxX - Constants.radius,
                                        y: rect.maxY - Constants.radius), radius: Constants.radius, startAngle: -CGFloat.pi / 6, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + corners.bottomLeft, y: rect.maxY))
        
        if corners.bottomLeft > 0 {
            let center = CGPoint(x: rect.minX + corners.bottomLeft, y: rect.maxY - corners.bottomLeft)
            path.addArc(withCenter: center, radius: corners.bottomLeft, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        }
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + corners.topLeft))
        if corners.topLeft > 0 {
            let center = CGPoint(x: rect.minX + corners.topLeft, y: rect.minY + corners.topLeft)
            path.addArc(withCenter: center, radius: corners.topLeft, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
        }
        path.close()
        
        return path
    }
}
