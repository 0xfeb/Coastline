//
//  Optional+Functional.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension Optional {
	// 解封一个对象并且执行一个函数
	func act(_ event:(Wrapped)->()) -> Optional {
		if let n = self { event(n) }
		return self
	}
	
	// 解封对象, 如果对象不存在, 返回缺省值
	func val(def:Wrapped) -> Wrapped {
		if let n = self { return n }
		return def
	}
}

// 选择两个可选值中的存在值, 如果一个都不存在, 返回缺省值
func choose<T>(_ v0:T?, _ v1:T?, def:T) -> T {
	if let val = v0 { return val }
	if let val = v1 { return val }
	return def
}
