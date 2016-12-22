//
//  String+Json.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/16.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension String {
	public init?(json:Any) {
		if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
			if let str = data.string {
				self = str
			} else {
				return nil
			}
		} else {
			return nil
		}
	}
	
	public var json:Any? {
		if let jsonData = self.data(using: .utf8) {
			return try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
		}
		return nil
	}
}
