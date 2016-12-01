//
//  AttributeString+Attribute.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public struct CLAttributeString {
	var str:String
	var attrs:CLAttributes
}

public extension String {
	var attributed:CLAttributeString {
		return CLAttributeString(str: self, attrs: CLAttributes())
	}
}

public extension NSAttributedString {
	static func build(list:[CLAttributeString]) -> NSAttributedString {
		let s = NSMutableAttributedString()
		for n in list {
			let item = NSAttributedString(string: n.str, attributes: n.attrs.dict)
			s.append(item)
		}
		return s as NSAttributedString
	}
}
