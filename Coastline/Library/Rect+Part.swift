//
//  Rect+Part.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGRect {
	var center:CGPoint {
		get {
			return CGPoint(x: width/2+minX, y: height/2+minY)
		}
		set {
			origin = CGPoint(x: newValue.x-width/2, y: newValue.y-height/2)
		}
	}
	
	var centerH:CGFloat {
		get {
			return midX
		}
		set {
			origin = CGPoint(x: newValue-width/2, y: minY)
		}
	}
	
	var centerV:CGFloat {
		get {
			return midY
		}
		set {
			origin = CGPoint(x: minX, y: newValue-height/2)
		}
	}
	
	var leftTop:CGPoint {
		get {
			return origin
		}
		set {
			origin = newValue
		}
	}
	
	var rightTop:CGPoint {
		get {
			return CGPoint(x: maxX, y: minY)
		}
		set {
			origin = CGPoint(x: newValue.x-width, y: newValue.y)
		}
	}
	
	var leftBottom:CGPoint {
		get {
			return CGPoint(x: minX, y: maxY)
		}
		set {
			origin = CGPoint(x: newValue.x, y: newValue.y-height)
		}
	}
	
	var rightBottom:CGPoint {
		get {
			return CGPoint(x: maxX, y: maxY)
		}
		set {
			origin = CGPoint(x: newValue.x-width, y: newValue.y-height)
		}
	}
	
	var left:CGFloat {
		get {
			return minX
		}
		set {
			origin = CGPoint(x: newValue, y: minY)
		}
	}
	
	var right:CGFloat {
		get {
			return maxX
		}
		set {
			origin = CGPoint(x: newValue-width, y: minY)
		}
	}
	
	var top:CGFloat {
		get {
			return minY
		}
		set {
			origin = CGPoint(x: minX, y: newValue)
		}
	}
	
	var bottom:CGFloat {
		get {
			return maxY
		}
		set {
			origin = CGPoint(x: minX, y: newValue-height)
		}
	}
}
