//
//  UIApplication+Config.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIApplication {
	private static let BASE_URL_KEY = "baseURL"
	private static let APP_VERSION_KEY = "CFBundleShortVersionString"
	private static let BUILD_VERSION_KEY = "CFBundleVersion"
	private static let APP_NAME_KEY = "CFBundleDisplayName"
	
	// 获取应用的Scheme名称
	public var scheme:String? {
		get { return Bundle.main.bundleIdentifier }
	}
	
	public var appName:String? {
		get { return configString(UIApplication.APP_NAME_KEY) }
	}
	
	// 获取plist中的配置信息
	public func config(_ key:String) -> AnyObject? {
		return Bundle.main.object(forInfoDictionaryKey: key) as AnyObject?
	}
	
	// 获取plist中的配置信息(字符串)
	public func configString(_ key:String) -> String? {
		return config(key) as? String
	}
	
	// 获取语言
	public func language() -> String? {
		//return (UserDefaults.standard.object(forKey: "AppleLanguages") as? [String])?.first
		return NSLocale.current.languageCode
	}
	
	// 获取应用版本
	public var appVersion:String? {
		get { return configString(UIApplication.APP_VERSION_KEY) }
	}
	
	// 获取应用编译版本
	public var buildVerison:String? {
		get { return configString(UIApplication.BUILD_VERSION_KEY) }
	}
	
	// 获取操作系统版本
	public var systemVersion:String {
		get { return UIDevice.current.systemVersion }
	}
	
	// 获取基础URL字符串
	public var baseURL:String? {
		get { return configString(UIApplication.BASE_URL_KEY) }
	}
	
	// 获取url列表
	public var urlList:[String:[String]] {
		guard let list = config("CFBundleURLTypes") as? [[AnyHashable:Any]] else { return [:] }
		
		var result:[String:[String]] = [:]
		list.forEach {
			let key = $0["CFBundleURLName"] as! String
			let value = $0["CFBundleURLSchemes"] as! [String]
			result[key] = value
		}
		
		return result
	}
	
	public var urlSimpleList:[String:String] {
		guard let list = config("CFBundleURLTypes") as? [[AnyHashable:Any]] else { return [:] }
		
		var result:[String:String] = [:]
		list.forEach {
			let key = $0["CFBundleURLName"] as! String
			let schemes = $0["CFBundleURLSchemes"] as! [String]
			if let value = schemes.first {
				result[key] = value
			}
		}
		
		return result
	}
	
	public func urlScheme(url:URL) -> String? {
		guard let list = config("CFBundleURLTypes") as? [[AnyHashable:Any]] else { return nil }
		let urlString = url.absoluteString
		
		for n in list {
			if let value = n["CFBundleURLSchemes"] as? [String] {
				if value.one({ urlString.hasPrefix($0) }) != nil {
					return n["CFBundleURLName"] as? String
				}
			}
		}
		
		return nil
	}
}
