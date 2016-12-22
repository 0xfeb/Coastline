//
//  UIGestureRecognizer.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/15.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
	public func testIn(view:UIView) -> Bool {
		let point = self.location(in: view)
		return view.bounds.contains(point)
	}
}
