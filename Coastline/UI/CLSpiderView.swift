//
//  CLSpiderView.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/4/10.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public class CLSpiderView: UIView {
	public var color0:UIColor = UIColor(red: 1, green: 0, blue: 1, alpha: 0.4)
	public var color1:UIColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.4)
	var currentRate:CGFloat = 0
	var timer:Timer?
	public var scores:[Int] = [0, 0, 0, 0, 0] {
		didSet {
			timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(scoreTimerAction), userInfo: nil, repeats: true)
		}
	}
	
	public var maxScore:Int = 5
	
	public override func draw(_ rect: CGRect) {
		let rc = rect.insetBy(dx: 0.5, dy: 0.5)
		drawZhiZhuBack(rect: rc, step: maxScore)
		
		let  prc = self.bounds.bigger(rate: CGFloat(currentRate))
		drawScore(items: scores, rect: prc, step: maxScore)
	}
	
	func  scoreTimerAction() {
		currentRate += 0.1
		if currentRate >= 0.9 {
			timer?.invalidate()
		}
		
		self.setNeedsDisplay()
	}
	
	//从正上方开始顺时针
	func drawScore(items:[Int], rect:CGRect, step:Int) {
		let pts = scoreToPoint(items: items, rect: rect, step: step)
		let path = UIBezierPath()
		path.move(to: pts[0])
		for n in 1..<items.count {
			path.addLine(to: pts[n])
		}
		path.close()
		UIColor.gray.setStroke()
		path.stroke()
		_ = path.fillGradient((rect.left, rect.top, color0),
		                      (rect.right, rect.bottom, color1))
	}
	
	func scoreToPoint(items:[Int], rect:CGRect, step:Int) -> [CGPoint] {
		var pt:[CGPoint] = []
		for p in items.enumerated() {
			let r = rect.bigger(rate: CGFloat(p.element)/CGFloat(step))
			let l = pantiInRect(rect: r)
			pt.append(l[p.offset])
		}
		return pt
	}
	
	func drawZhiZhuBack(rect:CGRect, step:Int) {
		for n in 1...step {
			let r = rect.bigger(rate: CGFloat(n)/CGFloat(step))
			drawItem(rect: r)
		}
		
		let center = rect.center
		let points = pantiInRect(rect: rect)
		let path = UIBezierPath()
		for n in 0..<points.count {
			path.move(to: center)
			path.addLine(to: points[n])
		}
		UIColor.lightGray.setStroke()
		path.stroke()
		
	}
	
	func drawItem(rect:CGRect) {
		let point = pantiInRect(rect: rect)
		print(point)
		if let path = pathByPoints(points: point) {
			path.lineWidth = 1.0
			path.lineCapStyle = .round
			UIColor.gray.setStroke()
			path.stroke()
		}
	}
	
	func pantiInRect(rect:CGRect) -> [CGPoint] {
		return [
			CGPoint(x:rect.centerH, y:rect.top),
			CGPoint(x:rect.right, y:rect.top + rect.height*0.3632712640),
			CGPoint(x:rect.left + rect.width*0.7931142925, y:rect.bottom),
			CGPoint(x:rect.left + rect.width*0.2068857075, y:rect.bottom),
			CGPoint(x:rect.left, y:rect.top + rect.height*0.3632712640)
		]
	}
	
	func pathByPoints(points:[CGPoint]) -> UIBezierPath? {
		if points.count < 3 { return nil }
		
		let path = UIBezierPath()
		path.move(to: points[0])
		for n in 1..<(points.count) {
			path.addLine(to: points[n])
		}
		path.close()
		return path
	}
}
