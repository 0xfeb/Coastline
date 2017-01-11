//
//  String+URL.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/14.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	public var url:URL? {
		if let str = self.urlString {
			return URL(string: str)
		}
		return nil
	}
	
	public var fileURL:URL {
		return URL(fileURLWithPath: self)
	}
	
	public var urlString: String? {
		return  self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
	}
	
	public var unUrlString: String? {
		return self.removingPercentEncoding
	}
	
	public var urlParts: [String:String]? {
		let reqs = self.components(separatedBy: "?")
		if reqs.count == 0 {
			return nil
		}
		
		var result:[String:String] = [:]
		result["body"] = reqs[0]
		
		if reqs.count > 1 {
			let paramString = reqs[1]
			let params = paramString.components(separatedBy: "&")
			
			for aParam in  params {
				let kv = aParam.head2Parts(gap: "=")
				
				if let key = kv.0.unUrlString, let value = kv.1?.unUrlString {
					result[key] = value
				}
			}
		}
		
		return result
	}
	
	static public func combineUrl(parts:[String:String]) -> String? {
		guard let body = parts["body"] else { return nil }
		var result = body + "?"
		
		for (k,v) in parts {
			if k == "body" { continue }
			
			if let key = k.urlString, let value = v.urlString {
				result += "\(key)=\(value)"
			}
		}
		return result
	}
}
