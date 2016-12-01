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
}
