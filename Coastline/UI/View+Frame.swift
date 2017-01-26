//
//  View+Frame.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIView {
	var frameWidth:CGFloat {
		get { return frame.size.width }
		set {
			var f = self.frame
			f.size.width = newValue
			self.frame = f
		}
	}
	
	var frameHeight:CGFloat {
		get { return frame.size.height }
		set {
			var f = self.frame
			f.size.height = newValue
			self.frame = f
		}
	}
	
	var frameLeft:CGFloat {
		get { return frame.origin.x }
		set {
			var f = self.frame
			f.origin.x = newValue
			self.frame = f
		}
	}
	
	var frameTop:CGFloat {
		get { return frame.origin.y }
		set {
			var f = self.frame
			f.origin.y = newValue
			self.frame = f
		}
	}
	
	var frameRight:CGFloat {
		get { return frame.origin.x + frame.size.width }
		set {
			var f = self.frame
			f.origin.x = newValue - frame.size.width
			self.frame = f
		}
	}
	
	var frameBottom:CGFloat {
		get { return frame.origin.y + frame.size.height }
		set {
			var f = self.frame
			f.origin.y = newValue - frame.size.height
			self.frame = f
		}
	}
	
	var frameCenterH:CGFloat {
		get { return frame.origin.x + frame.size.width / 2.0 }
		set {
			var f = self.frame
			f.origin.x = newValue - frame.size.width / 2.0
			self.frame = f
		}
	}
	
	var frameCenterV:CGFloat {
		get { return frame.origin.y + frame.size.height / 2.0 }
		set {
			var f = self.frame
			f.origin.y = newValue - frame.size.height / 2.0
			self.frame = f
		}
	}
	
	var frameCetner:CGPoint {
		get { return CGPoint(x: frameCenterH, y: frameCenterV) }
		set {
			self.frameCenterH = newValue.x
			self.frameCenterV = newValue.y
		}
	}
	
	var boundsCenterH:CGFloat {
		return bounds.origin.x + bounds.size.width / 2.0
	}
	
	var boundsCenterV:CGFloat {
		return bounds.origin.y + bounds.size.height / 2.0
	}
	
	var boundsCenter:CGPoint {
		return CGPoint(x: boundsCenterH, y: boundsCenterV)
	}
}
