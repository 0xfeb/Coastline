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
	private static let BUNDLE_ID_KEY = "CFBundleIdentifier"
	
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
	
	// 获取BundleID
	public var bundleId:String? {
		get { return configString(UIApplication.BUNDLE_ID_KEY) }
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
			guard let key = $0["CFBundleURLName"] as? String else { return }
			guard let value = $0["CFBundleURLSchemes"] as? [String] else { return }
			result[key] = value
		}
		
		return result
	}
	
	public var urlSimpleList:[String:String] {
		guard let list = config("CFBundleURLTypes") as? [[AnyHashable:Any]] else { return [:] }
		
		var result:[String:String] = [:]
		list.forEach {
			guard let key = $0["CFBundleURLName"] as? String else { return }
			guard let schemes = $0["CFBundleURLSchemes"] as? [String] else { return }
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
	
	public func appInfo(_ name:String) -> (AppId:String, AppSec:String)? {
		guard let d = config("third_app") as? [String:[String:String]] else { return nil }
		guard let dict = d[name], let aid = dict["app_id"] else { return nil }
		let sec = dict["app_sec"] ?? ""
		return (AppId:aid, AppSec:sec)
	}
	
	public var curAppInfo:(AppId:String?, AppSec:String?) {
		guard let d = config("current_app") as? [String:[String:String]] else { return (nil, nil) }
		guard let dict = d["info"] else { return (nil, nil) }
		let aid = dict["app_id"]
		let sec = dict["app_sec"]
		return (AppId:aid, AppSec:sec)
	}
	
	public var channel:String? {
		guard let d = config("current_app") as? [String:[String:String]] else { return nil }
		guard let dict = d["info"] else { return nil }
		return dict["channel"]
	}
	
	public func switchKey(key:String) -> String? {
		guard let d = config("current_app") as? [String:[String:String]] else { return nil }
		guard let dict = d["switchs"] else { return nil }
		return dict[key]
	}
	
	public func baseUrl(module:String?) -> String? {
		guard let d = config("current_app") as? [String:[String:String]] else { return nil }
		guard let dict = d["base_urls"] else { return nil }
		let m = module ?? "*"
		guard let url = dict[m] else { return dict["*"] }
		return url
	}
}
