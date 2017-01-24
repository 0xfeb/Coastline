//
//  URL+Req.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/24.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public enum RequestMethod : String  {
	case GET = "GET"
	case POST = "POST"
	case PUT = "PUT"
	case DELETE = "DELETE"
	case OPTION = "OPTION"
}

public extension URL {
	public var request:URLRequest  {
		return URLRequest(url: self)
	}
	
	public func request(_ method:RequestMethod, data:Data?) -> URLRequest {
		let req = NSMutableURLRequest(url: self)
		req.httpBody = data
		return req.copy() as! URLRequest
	}
	
	public func request(_ method:RequestMethod, string:String?) -> URLRequest {
		return request(method, data: string?.data(using: String.Encoding.utf8))
	}
	
	public func request(_ method:RequestMethod, dict:[AnyHashable:Any]?) -> URLRequest {
		var data:Data?
		if let dict = dict {
			data = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
		}
		return request(method, data: data)
	}
}
