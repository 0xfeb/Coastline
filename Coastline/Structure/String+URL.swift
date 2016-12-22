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
	
	var urlString: String? {
		return  self.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
	}
}
