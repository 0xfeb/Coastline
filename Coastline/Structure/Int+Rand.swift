//
//  Int+Rand.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/2/23.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public func arc4random<T:Integer> (type: T.Type) -> T {
	var r: T = 0
	arc4random_buf(&r, MemoryLayout<T>.size)
	return r
}

public extension UInt64 {
	public static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
		var m: UInt64
		let u = upper - lower
		var r = arc4random(type: UInt64.self)
		if u > UInt64(Int64.max) {
			m = 1 + ~u
		} else {
			m = ((max - (u * 2)) + 1) % u
		}
		while r < m {
			r = arc4random(type: UInt64.self)
		}
		return (r % u) + lower
	}
}
