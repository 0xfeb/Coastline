
//
//  Regex.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

class CLRegex {
	let internalExpression: NSRegularExpression
	let pattern: String
	
	init?(_ pattern: String) {
		self.pattern = pattern
		if let e = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
			internalExpression = e
		} else {
			return nil
		}
	}
	
	func test(_ input: String) -> Bool {
		let matches = self.internalExpression.matches(in: input, options: .anchored, range:NSMakeRange(0, input.characters.count))
		return matches.count > 0
	}
}


infix operator =~

func =~ (input:String, pattern:String) -> Bool {
	if let reg = CLRegex(pattern) {
		return reg.test(input)
	}
	return false
}
