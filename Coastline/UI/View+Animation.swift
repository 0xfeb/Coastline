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
}
