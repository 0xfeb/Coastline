//
//  View+Animation.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/20.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIView {
	public func shake(_ duration:TimeInterval, times:Int, offset:CGFloat, completion: ((Bool) -> Swift.Void)? = nil) {
		UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: { [weak self] in
			guard let view = self else { return }
			let perTime = 1.0 / Double(times)
			let basePos = view.frameLeft
			for n in 0..<times {
				let start = Double(n) * perTime
				if n ==  times - 1 {
					UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: perTime, animations: { [weak view, basePos] in
						view?.frameLeft = basePos
					})
				} else if n % 2 == 0 {
					UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: perTime, animations: { [weak view, basePos, offset] in
						view?.frameLeft = basePos - offset
					})
				} else {
					UIView.addKeyframe(withRelativeStartTime: start, relativeDuration: perTime, animations: { [weak view, basePos, offset] in
						view?.frameLeft = basePos + offset
					})
				}
			}
		}, completion: completion)
	}
	
	public func popOut(_ duration:TimeInterval, completion:((Bool)-> Swift.Void)? = nil) {
		guard let sv = self.superview else {
			completion?(false)
			return
		}
		
		self.frameTop = sv.bounds.height
		self.frameCenterH = sv.bounds.width / 2.0
		
		UIView.animateKeyframes(withDuration: duration+0.3, delay: 0, options: UIViewKeyframeAnimationOptions(), animations: { [weak self, weak sv, duration] in
			guard let view = self, let sv = sv else { return }
			
			let p0 = duration / (duration + 0.3)
			let pL = (1.0 - p0) / 3.0
			UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: p0, animations: { [weak view, weak sv] in
				guard let sv = sv else { return }
				view?.frameTop = sv.bounds.height * 2.0 / 3.0
			})
			UIView.addKeyframe(withRelativeStartTime: p0, relativeDuration: pL, animations: {  [weak view, weak sv] in
				guard let sv = sv else { return }
				view?.frameTop = sv.bounds.height * 2.0 / 3.0 - 5.0
			})
			UIView.addKeyframe(withRelativeStartTime: p0+pL, relativeDuration: pL, animations: {  [weak view, weak sv] in
				guard let sv = sv else { return }
				view?.frameTop = sv.bounds.height * 2.0 / 3.0 + 5.0
			})
			UIView.addKeyframe(withRelativeStartTime: p0+2*pL, relativeDuration: pL, animations: {  [weak view, weak sv] in
				guard let sv = sv else { return }
				view?.frameTop = sv.bounds.height * 2.0 / 3.0
			})
		}, completion: completion)
	}
	
	public func unPopOut(_ duration:TimeInterval, completion:((Bool)-> Swift.Void)? = nil) {
		UIView.animate(withDuration: duration, animations: { [weak self] in
			guard let sv = self?.superview else { return }
			self?.frameTop = sv.bounds.height
		}, completion: completion)
	}
	
	
	
	
	public func startWaiting(title:String, timeout:TimeInterval = 5.0) {
		killWaiting()
		
		let backView = UIView(frame: self.bounds)
		backView.tag = 12301
		backView.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 0.4)
		self.addSubview(backView)
		
		let barView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
		barView.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.4, blue: 0.4, alpha: 0.9)
		barView.frameCetner = backView.boundsCenter
		barView.layer.masksToBounds = true
		barView.layer.cornerRadius = 8.0
		backView.addSubview(barView)
		
		let pgLayer = CAShapeLayer()
		let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40))
		path.lineWidth = 20
		pgLayer.fillColor = nil
		pgLayer.strokeColor = UIColor.white.cgColor
		pgLayer.path = path.cgPath
		pgLayer.strokeStart = 0.0
		pgLayer.strokeEnd = 0.8
		pgLayer.lineWidth = 5
		pgLayer.lineCap = kCALineCapRound
		pgLayer.frame = CGRect(center:barView.bounds.center, size:CGSize(width:40, height:40)).offsetBy(dx: 0, dy: -5)
		barView.layer.addSublayer(pgLayer)
		pgLayer.addCycleAnimation()
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.white
		label.text = title
		label.frameCetner = barView.boundsCenter
		label.textAlignment = .center
		label.frameTop += 40
		barView.addSubview(label)
		
		if timeout > 0.0 {
			Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(killWaiting), userInfo: nil, repeats: false)
		}
	}
	
	public func killWaiting() {
		let view = self.viewWithTag(12301)
		view?.removeFromSuperview()
	}
	
	public func startHud(title:String, timeout:TimeInterval = 0.0) {
		killHud()
		
		let textSize = title.textSize(UIFont.systemFont(ofSize: 14))
		
		let barView = UIView(frame: CGRect(x: 0, y: 0, width: textSize.width + 20, height: textSize.height + 10))
		barView.tag = 12302
		barView.backgroundColor = UIColor.black
		barView.layer.masksToBounds = true
		barView.layer.cornerRadius = 8.0
		self.addSubview(barView)
		
		let label = UILabel(frame: barView.bounds)
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.white
		label.text = title
		label.textAlignment = .center
		barView.addSubview(label)
		
		barView.popOut(0.1) { [weak self, timeout] (r) in
			guard let s = self else { return }
			if r && timeout > 0.0 {
				Timer.scheduledTimer(timeInterval: timeout, target: s, selector: #selector(s.killHud), userInfo: nil, repeats: false)
			}
		}
	}
	
	public func stopHud() {
		let view = self.viewWithTag(12302)
		view?.unPopOut(0.2, completion: { [weak self] (r) in
			self?.killHud()
		})
	}
	
	public func killHud() {
		let view = self.viewWithTag(12302)
		view?.removeFromSuperview()
	}
}
