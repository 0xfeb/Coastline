//
//  Builder.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

func build<T>(_ t:T, event:(T)->()) -> T {
	event(t)
	return t
}
