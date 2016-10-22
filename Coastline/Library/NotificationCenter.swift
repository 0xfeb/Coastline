//
//  NotificationCenter.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension NotificationCenter {
	static func send(_ name:String, userInfo:[AnyHashable:Any]? = nil) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil, userInfo: userInfo)
	}
	
	static func received(_ name:String, event:@escaping ([AnyHashable:Any]?)->()) -> NSObjectProtocol {
		return NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: nil, queue: OperationQueue.main, using: { (noti) in
			event(noti.userInfo)
		})
	}
}
