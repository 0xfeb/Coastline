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
		let newSize = CGSize(width: self.width + size.width, height: self.height + size.height)
		return CGRect(center:self.center, size:newSize)
	}
	
	public func smaller(_ size:CGSize) -> CGRect {
		return bigger(CGSize(width: -size.width, height: -size.height))
	}
	
	public func bigger(rate: CGSize) -> CGRect {
		let newSize = CGSize(width:self.size.width * (rate.width-1), height:self.size.height * (rate.height-1))
		return bigger(newSize)
	}
	
	public func bigger(rate: CGFloat) -> CGRect {
		return bigger(rate: CGSize(width:rate, height:rate))
	}
}
