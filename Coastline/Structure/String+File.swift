//
//  String+File.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	// 将字符串写入文件
	func writeTo(_ path:String) -> Bool {
		return ((try? (self as NSString).write(toFile: path, atomically: true, encoding: String.Encoding.utf8.rawValue)) != nil)
	}
	
	init?(fromFile path:String) {
		if let s = try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) {
			self = s as String
		} else {
			return nil
		}
	}
}
