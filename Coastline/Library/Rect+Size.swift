//
//  Rect+Size.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGRect {
	func bigger(_ size:CGSize) -> CGRect {
		let w = max(size.width, 0) / 2
		let h = max(size.height, 0) / 2
		
		return CGRect(x: minX+w, y: minY+h, width: width+w, height: height+h)
	}
	
	func smaller(_ size:CGSize) -> CGRect {
		return bigger(CGSize(width: -size.width, height: -size.height))
	}
}
