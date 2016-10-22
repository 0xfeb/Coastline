//
//  String+FileName.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension String {
	// 添加Path项目
	func appendPath(_ path:String) -> String {
		return (self as NSString).appendingPathComponent(path)
	}
	
	// 将最后一个Path项目从文件目录中删除
	func popLastPath() -> String {
		return (self as NSString).deletingLastPathComponent
	}
	
	// 最后Path项目
	var lastPath:String {
		get {
			return (self as NSString).lastPathComponent
		}
	}
	
	// 去掉后缀名
	var withOutExt:String {
		get {
			return (self as NSString).deletingPathExtension
		}
	}
	
	// 后缀名
	var ext:String {
		get {
			return (self as NSString).pathExtension
		}
	}
	
	// 将文件名更换一个后缀名
	func withNewExt(_ ext:String) -> String {
		if ext.hasSuffix(".") { return withOutExt + ext }
		return withOutExt + "."+ext
	}
	
	// 根据主体和后缀名自动生成新的后缀名
	func unusedFileName(main:String, ext:String) -> String {
		let manager = FileManager.default
		let anExt = ext.isEmpty ? "" : ".\(ext)"
		var name = self.appendPath("\(main)\(anExt)")
		var index = 1
		while manager.fileExists(atPath: name) {
			name = self.appendPath("\(main)_\(index)\(anExt)")
			index += 1
		}
		
		return name
	}
}
