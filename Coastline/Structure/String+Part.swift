//
//  String+Part.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/11.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	public func head2Parts(gap:String) -> (String, String?) {
		guard let range = self.range(of: gap) else { return (self, nil) }
		
		let fstr = self.substring(to: range.lowerBound)
		let sstr = self.substring(from: range.upperBound)
		
		return (fstr, sstr)
	}
	
	public func tail2Parts(gap:String) -> (String?, String) {
		guard let range = self.range(of: gap, options: String.CompareOptions.backwards, range: nil, locale: nil)  else { return (nil, self) }
		
		let fstr = self.substring(to: range.lowerBound)
		let sstr = self.substring(from: range.upperBound)
		
		return (fstr, sstr)
	}
}
