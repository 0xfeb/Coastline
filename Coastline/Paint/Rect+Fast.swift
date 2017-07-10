//
//  Rect+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/2.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGPoint {
	public init(_ x:Double,  _ y:Double) {
		self.init(x: CGFloat(x), y: CGFloat(y))
	}
	
	public func offsetOf(_ point:CGPoint) -> CGSize {
		return CGSize(width: x - point.x, height: y - point.y)
	}
}

public extension CGSize {
	public init(_ w:Double, _ h:Double) {
		self.init(width: CGFloat(w), height: CGFloat(h))
	}
}

public extension CGRect {
	public init(_ x:Double, _ y:Double, _ w:Double, _ h:Double) {
		self.init(origin: CGPoint(x, y), size: CGSize(w, h))
	}
	
	public init(center:CGPoint, size:CGSize) {
		self.init(origin: CGPoint(x: center.x - size.width/2, y: center.y - size.height/2), size: size)
	}
}

public func point(_ x:CGFloat, _ y:CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}

public func size(_ w:CGFloat, _ h:CGFloat) -> CGSize {
    return CGSize(width:w, height:h)
}

public func rect(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: w, height: h)
}
