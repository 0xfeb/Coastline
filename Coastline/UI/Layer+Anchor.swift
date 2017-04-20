//
//  Layer+Arch.swift
//  testAni
//
//  Created by 王渊鸥 on 2017/4/17.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public struct CALayerWithAnchor {
	var layer:CALayer
	var point0:CGPoint
	var point1:CGPoint
	
	public func move(newPoint0:CGPoint, newPoint1:CGPoint) {
		let c1 = centerOf(point0: newPoint0, point1: newPoint0)
		let c0 = centerOf(point0: point0, point1: point1)
		let trans0 = CATransform3DMakeTranslation(c1.x - c0.x, c1.y - c0.y, 0)
		
		let l1 = lengthOf(point0: newPoint0, point1: newPoint1)
		let l0 = lengthOf(point0: point0, point1: point1)
		let trans1 = CATransform3DScale(trans0, l1 / l0, l1 / l0, 1.0)
		
		let a1 = angleOf(point0: newPoint0, point1: newPoint1)
		let a0 = angleOf(point0: point0, point1: point1)
		let trans2 = CATransform3DRotate(trans1, a1 - a0, 0, 0, 1.0)
		
		layer.transform = trans2
	}
}

public extension CALayer {
	public func relationOf(point:CGPoint) -> CGPoint {
		let lx = self.frame.maxX - self.frame.minX
		let ly = self.frame.maxY - self.frame.minY
		let dx = point.x - self.frame.minX
		let dy = point.y - self.frame.minY
		let rx:CGFloat = lx == 0 ? 0 : dx / lx
		let ry:CGFloat = ly == 0 ? 0 : dy / ly
		
		return CGPoint(x: rx, y: ry)
	}
	
	public func byRelation(point:CGPoint) -> CGPoint {
		let lx = self.frame.size.width
		let ly = self.frame.size.height
		let dx = lx * point.x + self.frame.origin.x
		let dy = ly * point.y + self.frame.origin.y
		
		return CGPoint(x: dx, y: dy)
	}
	
	public func choose(anchor0:CGPoint, anchor1:CGPoint) -> CALayerWithAnchor {
		return CALayerWithAnchor(layer: self, point0: anchor0, point1: anchor1)
	}
}

public func centerOf(point0:CGPoint, point1:CGPoint) -> CGPoint {
	let x:CGFloat = (point1.x + point0.x) / 2.0
	let y:CGFloat = (point1.y + point0.y) / 2.0
	
	return CGPoint(x: x, y: y)
}

public func lengthOf(point0:CGPoint, point1:CGPoint) -> CGFloat {
	return sqrt(pow(point1.y - point0.y, 2) + pow(point1.x - point0.x, 2))
}

public func angleOf(point0:CGPoint, point1:CGPoint) -> CGFloat {
	return atan2(point1.y - point0.y, point1.x - point0.x)
}
