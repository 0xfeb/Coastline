//
//  String+Path.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	// Home路径
	public static var homePath: String {
		get { return NSHomeDirectory() }
	}
	
	// 文档路径
	public static var documentsPath: String {
		get { return homePath + "/Documents" }
	}
	
	// 库路径
	public static var libraryPath: String {
		get {  return homePath + "/Library" }
	}
	
	// Bundle路径
	public static var bundlePath: String {
		get { return Bundle().bundlePath }
	}
	
	// 寻找某个项目下的子项目
	public func pathsIn() -> [String] {
		let filePath = URL(fileURLWithPath: self)
		if let itor = FileManager.default.enumerator(at: filePath,
		                                          includingPropertiesForKeys: nil,
		                                          options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants],
		                                          errorHandler: nil) {
			return itor.allObjects.map{ ($0 as! URL).relativePath }
		}
		return []
	}
	
	// 寻找某个项目下递归寻找的所有子项目
	public func pathsDeepIn() -> [String] {
		let filePath = URL(fileURLWithPath: self)
		if let itor = FileManager.default.enumerator(at: filePath,
		                                             includingPropertiesForKeys: nil,
		                                             options: [.skipsHiddenFiles],
		                                             errorHandler: nil) {
			return itor.allObjects.map{ ($0 as! URL).relativePath }
		}
		return []
	}
	
	// 寻找某个项目下所有的文件
	public func filesIn() -> [String] {
		return pathsIn().filter{ $0.isFile == true }
	}
	
	// 寻找某个项目下所有的目录
	public func dirsIn() -> [String] {
		return pathsIn().filter{ $0.isDir == true }
	}
	
	// 递归寻找某个项目下所有的文件
	public func filesDeepIn() -> [String] {
		return pathsDeepIn().filter{ $0.isFile == true }
	}
	
	// 递归寻找某个项目下所有的目录
	public func dirsDeepIn() -> [String] {
		return pathsDeepIn().filter{ $0.isDir == true }
	}
	
	// 判断此项目是否为文件
	public var isFile: Bool? {
		get {
			if let attr = try? FileManager.default.attributesOfItem(atPath: self) {
				if let type:String = attr.val(FileAttributeKey.type.rawValue) {
					return type == FileAttributeType.typeRegular.rawValue
				}
			}
			return nil
		}
	}
	
	// 判断此项目是否为目录
	public var isDir: Bool? {
		get {
			if let attr = try? FileManager.default.attributesOfItem(atPath: self) {
				if let type:String = attr.val(FileAttributeKey.type.rawValue) {
					return type == FileAttributeType.typeDirectory.rawValue
				}
			}
			return nil
		}
	}
	
	// 创建目录
	public func createDir() -> Bool {
		return ((try? FileManager.default.createDirectory(atPath: self, withIntermediateDirectories: true, attributes: nil)) != nil)
	}
	
	// 删除项目
	public func removePath() -> Bool {
		return ((try? FileManager.default.removeItem(atPath: self)) != nil)
	}
}
