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
}
