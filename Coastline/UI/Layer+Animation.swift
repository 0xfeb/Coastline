//
//  Layer+Animation.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/27.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension CALayer {
	public func addCycleAnimation() {
		let ani = CABasicAnimation(keyPath: "transform.rotation.z")
		ani.toValue = NSNumber(value: Double.pi * 15)
		ani.duration = 8
		ani.repeatCount = 20
		self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
		self.add(ani, forKey: "rotation")
	}
}


