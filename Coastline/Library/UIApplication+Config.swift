//
//  UIApplication+Config.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension UIApplication {
	private static let BASE_URL_KEY = "baseURL"
	private static let LAST_VERSION_KEY = "lastVersion"
	
	// 获取应用的Scheme名称
	var scheme:String? {
		get { return Bundle.main.bundleIdentifier }
	}
	
	// 获取plist中的配置信息
	func config(_ key:String) -> AnyObject? {
		return Bundle.main.object(forInfoDictionaryKey: key) as AnyObject?
	}
	
	// 获取plist中的配置信息(字符串)
	func configString(_ key:String) -> String? {
		return config(key) as? String
	}
	
	// 获取应用版本
	var appVersion:String? {
		get { return configString("CFBundleShortVersionString") }
	}
	
	// 获取应用编译版本
	var buildVerison:String? {
		get { return configString("CFBundleVersion") }
	}
	
	// 获取操作系统版本
	var systemVersion:String {
		get { return UIDevice.current.systemVersion }
	}
	
	// 获取基础URL字符串
	var baseURL:String? {
		get { return configString(UIApplication.BASE_URL_KEY) }
	}
}
