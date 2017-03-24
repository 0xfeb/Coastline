//
//  Bool+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension Bool {
	// 将T类型的对象打包起来
	func packOptional<T>(_ t:T) -> T? {
		return self ? t : nil
	}
	
	func ifTrue(_ action:@escaping ()->()) -> Bool {
		if self { action() }
		return self
	}
	
	func ifFalse(_ action:@escaping ()->()) -> Bool {
		if !self { action() }
		return self
	}
}
