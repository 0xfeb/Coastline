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
	public var lineStyle: (width:CGFloat?, cap:CGLineCap?, join:CGLineJoin?) {
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
	public func move(_ x:CGFloat, _ y:CGFloat) -> UIBezierPath {
		self.move(to: CGPoint(x: x, y: y))
		return self
	}
	
	// 绘制一条直线
	public func line(_ x:CGFloat, _ y:CGFloat) -> UIBezierPath {
		self.addLine(to: CGPoint(x: x, y: y))
		return self
	}
	
	// 绘制一条曲线
	public func line(_ x:CGFloat, _ y:CGFloat, cx:CGFloat, cy:CGFloat) -> UIBezierPath {
		self.addQuadCurve(to: CGPoint(x: x, y: y), controlPoint: CGPoint(x: cx, y: cy))
		return self
	}
	
	// 将终点和起点连接
	public func link() -> UIBezierPath {
		self.close()
		return self
	}
	
	// 添加另外一个Path
	public func add(_ path:UIBezierPath) -> UIBezierPath {
		self.append(path)
		return self
	}
	
	// 按照颜色填充
	public func fill(_ color:UIColor) -> UIBezierPath {
		color.setFill()
		self.fill()
		return self
	}
	
	// 按照颜色绘制线条
	public func stroke(_ color:UIColor) -> UIBezierPath {
		color.setStroke()
		self.stroke()
		return self
	}

	// 填充渐变色
	public func fillGradient(_ from:(CGFloat, CGFloat, UIColor), _ to:(CGFloat, CGFloat, UIColor)) -> UIBezierPath {
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let context = UIGraphicsGetCurrentContext()
		let colors = [ from.2.cgColor, to.2.cgColor ]
		let locations:[CGFloat] = [ 0, 1 ]
		guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else { return self }
		
		context?.saveGState()
		self.addClip()
		context?.drawLinearGradient(gradient,
		                            start: CGPoint(x: from.0, y: from.1),
		                            end: CGPoint(x: to.0, y: to.1),
		                            options: CGGradientDrawingOptions.drawsAfterEndLocation)
		context?.restoreGState()
		return self
	}
	
	static public func +=(path0:UIBezierPath, path1:UIBezierPath) -> UIBezierPath {
		return path0.add(path1)
	}
}
