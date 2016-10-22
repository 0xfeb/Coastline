//
//  String+File.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension String {
	// 将字符串写入文件
	func save(_ path:String) -> Bool {
		return ((try? (self as NSString).write(toFile: path, atomically: true, encoding: String.Encoding.utf8.rawValue)) != nil)
	}
	
	// 从文件读取到字符串
	static func load(_ path:String) -> String? {
		let s = try? NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
		return s as String?
	}
}
