//
//  URL+Part.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/22.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import Foundation

public extension URL {
	public var params:[String:String?]? {
		guard let p = query else { return nil }
		return p.components(separatedBy: "&").toDict{ $0.head2Parts(gap: "=") }
	}
}
