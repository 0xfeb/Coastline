//
//  PauseTimer.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

class CLPauseTimer : NSObject {
	var timeInterval:TimeInterval = 0.0
	var timer:Timer?
	var event:(_ end:@escaping ()->Void)->Void = { _ in }
	
	init(_ timeInterval:TimeInterval, event:@escaping (_ end:@escaping ()->Void)->Void) {
		super.init()
		self.timeInterval = timeInterval
		self.event = event
		timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(CLPauseTimer.main), userInfo: nil, repeats: false)
		
	}
	
	@objc func main() {
		event {
			self.timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(CLPauseTimer.main), userInfo: nil, repeats: false)
		}
	}
	
	func invalidate() {
		timer?.invalidate()
	}
}

