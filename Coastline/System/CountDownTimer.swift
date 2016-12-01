//
//  CountDownTimer.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

//等待时间倒推的计时器
public class CLCountDownTimer {
	var currentCount:Int = 0
	var cdEvent:(_ number:Int)->() = { _ in }
	var timer:Timer?
	
	public init(max:Int, event:@escaping (_ number:Int)->()) {
		currentCount = max
		cdEvent = event
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CLCountDownTimer.main), userInfo: nil, repeats: true)
	}
	
	@objc func main() {
		if currentCount > 0 { currentCount = currentCount - 1 }
		else { timer!.invalidate() }
		cdEvent(currentCount)
	}
	
	func invalidate() {
		timer?.invalidate()
	}
}
