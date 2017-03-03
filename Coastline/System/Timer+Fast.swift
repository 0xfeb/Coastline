//
//  Timer+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/3.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension Timer {
	public var usedTime:TimeInterval {
		get {
			return Date().timeIntervalSince(self.fireDate)
		}
	}
}
