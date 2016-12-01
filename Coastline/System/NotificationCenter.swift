//
//  NotificationCenter.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

//通知的管理袋, 需要在系统结束的时候, 清空掉
public class CLNotificationBag {
	var notis:[NSObjectProtocol]
	
	public init() {
		notis = []
	}
	
	func addItem(obj:NSObjectProtocol) {
		self.notis.append(obj)
	}
	
	func clear() {
		notis.forEach{
			NotificationCenter.default.removeObserver($0)
		}
	}
	
	deinit {
		clear()
	}
}

public extension NSObjectProtocol {
	func addBag(_ bag:CLNotificationBag) {
		bag.addItem(obj: self)
	}
}

public extension NotificationCenter {
	//发送通知到外部
	static func send(_ name:String, userInfo:[AnyHashable:Any]? = nil) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil, userInfo: userInfo)
	}
	
	//接收通知内容
	static func received(_ name:String, event:@escaping ([AnyHashable:Any]?)->()) -> NSObjectProtocol {
		return NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: nil, queue: OperationQueue.main, using: { (noti) in
			event(noti.userInfo)
		})
	}
	
	//运行一次通知结果, 然后再等待接收通知
	static func runReceived(_ name:String, event:@escaping ([AnyHashable:Any]?)->()) -> NSObjectProtocol {
		event(nil)
		return received(name, event: event)
	}
}
