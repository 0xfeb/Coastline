//
//  Number+Convert.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/21.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension Double {
	public var intValue:Int {
		return (String(format:"%.0f", self) as NSString).integerValue
	}
	
}

public extension Float {
	public var intValue:Int {
		return (String(format:"%.0f", self) as NSString).integerValue
	}
}

public func limit<T:Comparable>(_ value:T, start:T, end:T) -> T {
	if value < start { return start }
	if value > end { return end }
	return value
}
