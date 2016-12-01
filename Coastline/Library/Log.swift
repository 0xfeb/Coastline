//
//  Log.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public struct CLLog {
	static func log(prefix:String, content:Any) {
		print(prefix)
		print(content)
	}
}

public extension CLLog {
	static func success(content:Any) {
		log(prefix: "🆗", content: content)
	}
	
	static func error(content:Any) {
		log(prefix: "🚫", content: content)
	}
	
	static func step(content:Any) {
		log(prefix: "🍊", content: content)
	}
}
