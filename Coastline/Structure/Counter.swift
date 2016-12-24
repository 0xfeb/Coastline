//
//  Counter.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public class CLCounter {
	public static var shareInstance:CLCounter = { CLCounter() }()
	
	var maxNumber:Int = 0
	var curNumber:Int = 0
	
	public static func startCount(endAt:Int) {
		let cl = CLCounter.shareInstance
		cl.maxNumber = endAt
		cl.curNumber = 0
	}
	
	public func addCount() {
		curNumber += 1
	}
	
	public var complete:Bool {
		return curNumber >= maxNumber
	}
	
	public var atEnd:Bool {
		addCount()
		return complete
	}
}
