//
//  Dictionary+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

// 大部分服务端返回的处理方式, 都是code, data, error这样的三组模式
// 在此处指定具体的key
struct JsonResponse {
	static public var CODE_KEY = "code"
	static public var DATA_KEY = "data"
	static public var ERROR_KEY = "error"
}

extension Dictionary {
	// 将一个Dictionary转换成新的Dictionary
	func mapDict<K, V>(_ event:(Key, Value)->(K, V)) -> [K:V] {
		var result:[K:V] = [:]
		for p in self {
			let r = event(p.key, p.value)
			result[r.0] = r.1
		}
		return result
	}
	
	// 针对JSON的分析处理工具, 返回指定类型
	func val<T>(_ key:String) -> T? {
		let k = key as! Key
		return self[k] as? T
	}
	
	// 针对JSON的分析处理工具, 返回指定类型, 如果值为空则返回指定缺省内容
	func val<T>(_ key:String, def:T) -> T {
		if let n:T = val(key) { return n }
		return def
	}
	
	// 针对JSON分析的返回值处理工具
	var parse:(code:Int, error:String?, data:AnyObject?) {
		get {
			let code:Int = val(JsonResponse.CODE_KEY, def:0)
			let error:String? = val(JsonResponse.ERROR_KEY)
			let data:AnyObject? = val(JsonResponse.DATA_KEY)
			return (code, error, data)
		}
	}
}
