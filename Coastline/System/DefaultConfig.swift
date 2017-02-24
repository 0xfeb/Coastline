//
//  DefaultConfig.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/2/24.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public class CLDefaultConfig {
	public static var shareInstance:CLDefaultConfig = { CLDefaultConfig() }()
	
	public var services:[String:[String:String]] = [:]
	public var baseUrls:[String] = []
	public var signs:[String:String] = [:]
	
	init() {
		if let svcs = UIApplication.shared.config("services") as? [String:[String:String]] {
			services = svcs
		}
		
		if let urls = UIApplication.shared.config("baseURL") as? [String] {
			baseUrls = urls
		}
		
		if let s = UIApplication.shared.config("sign") as? [String:String] {
			signs = s
		}
	}
	
	/**
	Service的结构:
	services {
		weibo:{
			id:"xxxx",
			sec:"xxxx"
		},
		wechat:{
			id:"xxxx",
			sec:"xxxx"
		},
		qq:{
			id:"xxxx",
			sec:"xxxx"
		}
	}
	**/
	public func service(name:String) -> (AppId:String?, AppSec:String?) {
		guard let s = services[name] else { return (nil, nil) }
		return (s["id"] ?? "", s["sec"])
	}
	
	public var baseURL:String? {
		return baseUrls.first
	}
	
	public var channel:String? {
		return signs["channel"]
	}
	
	public var isStoreVersion:Bool {
		return channel == "AppStore"
	}
}
