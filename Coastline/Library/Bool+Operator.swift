//
//  Bool+Operator.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

extension Bool {
	// 将T类型的对象打包起来
	func pack<T>(_ t:T) -> T? {
		return self ? t : nil
	}
}
