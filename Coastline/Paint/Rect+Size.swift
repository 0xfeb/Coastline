//
//  Rect+Size.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension CGRect {
	public func bigger(_ size:CGSize) -> CGRect {
//		let w = max(size.width, 0) / 2
//		let h = max(size.height, 0) / 2
//		
//		
//		
//		return CGRect(x: minX+w, y: minY+h, width: width+w, height: height+h)
		return insetBy(dx: -size.width, dy: -size.height)
	}
	
	public func smaller(_ size:CGSize) -> CGRect {
		return bigger(CGSize(width: -size.width, height: -size.height))
	}
	
	public func bigger(rate: CGSize) -> CGRect {
		let newSize = CGSize(width:self.size.width * rate.width, height:self.size.height * rate.height)
		return bigger(newSize)
	}

	public func bigger(rate: CGFloat) -> CGRect {
		return bigger(rate: CGSize(width:rate, height:rate))
	}
}
