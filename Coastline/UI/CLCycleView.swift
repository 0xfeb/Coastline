//
//  CLCycleView.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/4/11.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

class CLCycleView: UIView {
	public var colors:[UIColor] = [UIColor(colorLiteralRed: 1, green: 0, blue: 1, alpha: 0.4),
	                               UIColor(colorLiteralRed: 0, green: 1, blue: 1, alpha: 0.4),
	                               UIColor(colorLiteralRed: 1, green: 1, blue: 0, alpha: 0.4)]

	var currentRate:CGFloat = 0
	var timer:Timer?
	public var scores:[Int] = [0, 0, 0] {
		didSet {
			timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(scoreTimerAction), userInfo: nil, repeats: true)
		}
	}
	
	public var maxScore:Int = 5
	
	public override func draw(_ rect: CGRect) {
		let prc = rect.insetBy(dx: 10.0, dy: 10.0)
		drawScore(items: scores, rect: prc, step: maxScore)
	}
	
	func scoreTimerAction() {
		currentRate += 0.1
		if currentRate >= 0.9 {
			timer?.invalidate()
		}
		
		self.setNeedsDisplay()
	}
	
	func drawScore(items:[Int], rect:CGRect, step:Int)  {
		for n in items.enumerated() {
			if let path = pathOfScore(item: n.element, offset: n.offset, rect: rect, step: step) {
				let color = colors[n.offset]
				color.setStroke()
				path.stroke()
			}
		}
	}
	
	func pathOfScore(item:Int, offset:Int, rect:CGRect, step:Int) -> UIBezierPath? {
		let prc = rect.bigger(rate: CGFloat(offset)/3.0 )
		
		let score = CGFloat(item) * currentRate
		
		let path = UIBezierPath()
		_ = path.move(prc.midX, prc.minX)
		path.addArc(withCenter: prc.center, radius: prc.width/2.0, startAngle: CGFloat.pi * 3.0 / 4.0, endAngle: CGFloat.pi * score * 2.0 / CGFloat(step) + CGFloat.pi / 2.0, clockwise: true)
		
		path.lineCapStyle = .round
		path.lineWidth = 10.0
	
		return path
	}
}
