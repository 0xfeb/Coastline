//
//  Rect+Position.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGRect {
	public func squreOutside() -> CGRect {
		if self.width > self.height {
			return CGRect(x: self.minX, y: self.minY - (self.width-self.height)/2.0, width: self.width, height: self.width)
		} else {
			return CGRect(x: self.minX - (self.height-self.width)/2.0, y: self.minY, width: self.height, height: self.height)
		}
	}
	
	public func squreInside() -> CGRect {
		if self.width > self.height {
			return CGRect(x: self.minX + (self.width-self.height)/2.0, y: self.minY, width: self.height, height: self.height)
		} else {
			return CGRect(x: self.minX, y: self.minY + (self.height-self.width)/2.0, width: self.width, height: self.width)
		}
	}
	
	public func inside(_ edge:CGRectEdge, width:CGFloat) -> CGRect {
		switch edge {
		case .minXEdge:
			return CGRect(x: minX, y: minY, width: width, height: height)
		case .maxXEdge:
			return CGRect(x: minX + self.width - width, y: minY, width: width, height: height)
		case .minYEdge:
			return CGRect(x: minX, y: minY, width: self.width, height: width)
		case .maxYEdge:
			return CGRect(x: minX, y: minY + self.height - width, width: self.width, height: width)
		}
	}
	
	public func outside(_ edge:CGRectEdge, width:CGFloat) -> CGRect {
		switch edge {
		case .minXEdge:
			return CGRect(x: minX - width, y: minY, width: width, height: self.height)
		case .maxXEdge:
			return CGRect(x: maxX, y: minY, width: width, height: self.height)
		case .minYEdge:
			return CGRect(x: minX, y: minY - width, width: self.width, height: width)
		case .maxYEdge:
			return CGRect(x: minX, y: maxY, width: self.width, height: width)
		}
	}
	
	public func move(offset:CGSize) -> CGRect {
		let pt = CGPoint(x:self.center.x + offset.width, y:self.center.y + offset.height)
		return CGRect(center: pt, size: self.size)
	}
	
	public mutating func moved(offset:CGSize) {
		center = CGPoint(x:self.center.x + offset.width, y:self.center.y + offset.height)
	}
	
	public func resizeByCenter(size:CGSize) -> CGRect {
		return CGRect(center: self.center, size: size)
	}
	
	public mutating func resizedByCenter(size:CGSize) {
		self = CGRect(center: self.center, size: size)
	}
}
