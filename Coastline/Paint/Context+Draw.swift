//
//  Context+Draw.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGContext {
	
	// 获取当前绘制对象
	static func current() -> CGContext? {
		return UIGraphicsGetCurrentContext()
	}
	
	// 按照高度尺寸上下翻转
	func flipV(_ inHeight:CGFloat) {
		self.textMatrix = CGAffineTransform.identity
		self.translateBy(x: 0, y: inHeight)
		self.scaleBy(x: 1.0, y: -1.0)
	}
}
