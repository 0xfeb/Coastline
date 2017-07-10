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

public func between<T:Comparable>(_ value:T, start:T, end:T) -> T {
	if value < start { return start }
	if value > end { return end }
	return value
}

public func avg<T:Integer>(_ value1:T, _ value2:T) -> T {
	return (value1 + value2) / 2
}

public func avg<T:FloatingPoint>(_ value1:T, _ value2:T) -> T {
	return (value1 + value2) / 2
}

extension Comparable {
	func limit(start:Self,  end:Self) -> Self {
		return between(self, start: start, end: end)
	}
}
