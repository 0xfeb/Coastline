//
//  String+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	// 获取子字符串
	public subscript(range:Range<Int>) -> String {
		let start = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
		let end = self.characters.index(self.startIndex, offsetBy: range.upperBound)
		let indexRange:Range<String.Index> = start..<end
		return self[indexRange]
	}
	
	// 获取某个字符
	public subscript(index:Int) -> String {
		return self[index..<(index+1)]
	}
	
	// 清除周边多余字符
	public func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}
	
	// 子字符串(From)
	public func subStringFrom(_ index:Int) -> String {
		return self.substring(from: self.characters.index(self.startIndex, offsetBy: index))
	}
	
	// 子字符串(To)
	public func subStringTo(_ index:Int) -> String {
		return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
	}
	
	//
	public func containChar(chars:CharacterSet) -> Bool {
		for c in self.unicodeScalars {
			if chars.contains(c) { return true }
		}
		return false
	}
	
	public func isChars(chars:CharacterSet) -> Bool {
		for c in self.unicodeScalars {
			if !chars.contains(c) { return false }
		}
		return true
	}
    
    public var isChinese: Bool {
        let match = "(^[\u{4e00}-\u{9fa5}]+$)"
        let predicate = NSPredicate(format: "SELF matches %@", match)
        return predicate.evaluate(with: self)
    }
}
