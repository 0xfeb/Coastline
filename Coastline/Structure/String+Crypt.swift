//
//  String+Crypt.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	// 获取MD5加密, 使用soffes/Crypto替代原来的md5
	
	// 获取Base64加密
	var base64Enc: String? {
		get {
			let data = self.data(using: String.Encoding.utf8)
			return data?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
		}
	}
	
	// 获取Base64解密
	var base64Dec: String? {
		get {
			if let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) {
				if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
					return result as String
				}
			}
			return nil
		}
	}
	
	// 生成一个UUID值
	static var UUID:String {
		get {
			let puuid = CFUUIDCreate(nil)
			let suuid = CFUUIDCreateString(nil, puuid)
			return "\(suuid)"
		}
	}
}
