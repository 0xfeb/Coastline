//
//  OperationQueue+Proc.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public class CLProc<T> {
	var queue:OperationQueue
	var method:()->T? = { nil }
	
	init(queue:OperationQueue, method:@escaping ()->T?) {
		self.queue = queue
		self.method = method
	}
	
	func result(_ response:@escaping (T?)->()) {
		queue.addOperation {
			let result = self.method()
			OperationQueue.main.addOperation({
				response(result)
			})
		}
	}
}

//将同步动作封装成异步模式的一种表达方式
extension OperationQueue {
	func proc<T>(_ method:@escaping ()->T?) -> CLProc<T> {
		return CLProc(queue: self, method: method)
	}
}
