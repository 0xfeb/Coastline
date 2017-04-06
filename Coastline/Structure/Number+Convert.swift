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