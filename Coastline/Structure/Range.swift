//
//  Range.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/2/8.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension Range where Bound : SignedInteger {
	public init(inc start:Bound, inc end:Bound) {
		self.init(uncheckedBounds:(start, end))
	}
	
	public init(inc start:Bound, exc end:Bound) {
		self.init(uncheckedBounds:(start, end-1))
	}
	
	public init(exc start:Bound, inc end:Bound) {
		self.init(uncheckedBounds:(start+1, end))
	}
	
	public init(exc start:Bound, exc end:Bound) {
		self.init(uncheckedBounds:(start+1, end-1))
	}
}
