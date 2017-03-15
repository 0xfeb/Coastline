//
//  ScrollView+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/3/8.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIScrollView {
	public func centerDistance(view:UIView) -> CGSize {
		return view.center.offsetOf(viewCenterPoint)
	}
	
	public var viewRect:CGRect {
		return CGRect(origin:contentOffset ,size:bounds.size)
	}

	public var viewCenterPoint:CGPoint {
		return viewRect.center
	}
}
