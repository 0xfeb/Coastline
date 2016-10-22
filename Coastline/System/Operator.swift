//
//  Choose.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public func choose<T>(_ v:T?...) -> T? {
	for n in v {
		if let n = n { return n }
	}
	
	return nil
}

public func setting<T>(_ item:T, _ action:(T)->Void) -> T {
	action(item)
	return item
}
