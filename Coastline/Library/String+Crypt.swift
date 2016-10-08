//
//  String+Crypt.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension String {
	// 获取MD5加密
	var md5 : String{
		get {
			let str = self.cString(using: String.Encoding.utf8)
			let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
			let digestLen = Int(CC_MD5_DIGEST_LENGTH)
			let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
			CC_MD5(str!, strLen, result)
			let hash = NSMutableString()
			for i in 0 ..< digestLen {
				hash.appendFormat("%02x", result[i])
			}
			result.deinitialize()
			return String(format: hash as String)
		}
	}
	
	// 获取加盐数值
	func passcode(salt:String) -> String {
		return (self.md5 + salt).md5
	}
	
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
