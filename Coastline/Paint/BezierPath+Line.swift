//
//  BezierPath+Line.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension UIBezierPath {
	// 读取或写入线条的绘制模式
	var lineStyle: (width:CGFloat?, cap:CGLineCap?, join:CGLineJoin?) {
		get {
			return (lineWidth, lineCapStyle, lineJoinStyle)
		}
		
		set(val) {
			if let w = val.width { lineWidth = w }
			if let c = val.cap { lineCapStyle = c }
			if let j = val.join { lineJoinStyle = j }
		}
	}
	
	// 移动当前控制点
	func move(_ x:CGFloat, _ y:CGFloat) -> UIBezierPath {
		self.move(to: CGPoint(x: x, y: y))
		return self
	}
	
	// 绘制一条直线
	func line(_ x:CGFloat, _ y:CGFloat) -> UIBezierPath {
		self.addLine(to: CGPoint(x: x, y: y))
		return self
	}
	
	// 绘制一条曲线
	func line(_ x:CGFloat, _ y:CGFloat, cx:CGFloat, cy:CGFloat) -> UIBezierPath {
		self.addQuadCurve(to: CGPoint(x: x, y: y), controlPoint: CGPoint(x: cx, y: cy))
		return self
	}
	
	// 将终点和起点连接
	func link() -> UIBezierPath {
		self.close()
		return self
	}
	
	// 添加另外一个Path
	func add(_ path:UIBezierPath) -> UIBezierPath {
		self.append(path)
		return self
	}
	
	// 按照颜色填充
	func fill(_ color:UIColor) -> UIBezierPath {
		color.setFill()
		self.fill()
		return self
	}
	
	// 按照颜色绘制线条
	func stroke(_ color:UIColor) -> UIBezierPath {
		color.setStroke()
		self.stroke()
		return self
	}

	// 填充渐变色
	func fillGradient(_ from:(CGFloat, CGFloat, UIColor), _ to:(CGFloat, CGFloat, UIColor)) {
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let context = UIGraphicsGetCurrentContext()
		let colors = [ from.2.cgColor, to.2.cgColor ]
		let locations:[CGFloat] = [ 0, 1 ]
		guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return }
		
		context?.saveGState()
		self.addClip()
		context?.drawLinearGradient(gradient,
		                            start: CGPoint(x: from.0, y: from.1),
		                            end: CGPoint(x: to.0, y: to.1),
		                            options: CGGradientDrawingOptions.drawsAfterEndLocation)
		context?.restoreGState()
	}
}
