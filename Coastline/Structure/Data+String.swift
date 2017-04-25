//
//  Data+String.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension Data {
	var string:String? {
		return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
	}
	
	var prettyJsonString:String? {
		guard let dict = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) else { return nil }
		guard let d = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
		
		return d.string
	}
}
