//
//  MutableAttributeString+Warpper.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

struct NSMutableAttributedStringWarpper {
	var str:NSMutableAttributedString
	var range:NSRange
	
	// 设置文本的属性
	func set(_ attrs:CLAttributes) -> NSMutableAttributedString {
		str.setAttributes(attrs.dict, range: range)
		return str
	}
}

extension NSMutableAttributedString {
	// 在某个范围内
	func at(_ start:Int, _ length:Int) -> NSMutableAttributedStringWarpper {
		let rg = NSRange(location: start, length: length)
		return NSMutableAttributedStringWarpper(str: self, range: rg)
	}
	
	// 在某个范围内
	func at(_ range:NSRange) -> NSMutableAttributedStringWarpper {
		return NSMutableAttributedStringWarpper(str: self, range: range)
	}
}

/*
使用方法
str.at(0, 2).set(..)
*/
