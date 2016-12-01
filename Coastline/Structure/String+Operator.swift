//
//  String+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension String {
	// 获取子字符串
	subscript(range:Range<Int>) -> String {
		let start = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
		let end = self.characters.index(self.startIndex, offsetBy: range.upperBound)
		let indexRange:Range<String.Index> = start..<end
		return self[indexRange]
	}
	
	// 获取某个字符
	subscript(index:Int) -> String {
		return self[index..<(index+1)]
	}
	
	// 清除周边多余字符
	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	// 子字符串(From)
	func subStringFrom(_ index:Int) -> String {
		return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
	}
	
	// 子字符串(To)
	func subStringTo(_ index:Int) -> String {
		return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
	}
}
