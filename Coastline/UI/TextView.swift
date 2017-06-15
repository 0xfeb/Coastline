//
//  TextView.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/6/15.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UITextView {
	public func autoHeightConstraint() {
		if let n = self.constraints.index(where: { $0.firstAttribute == .height })  {
			self.constraints[n].constant = self.contentSize.height
		}
	}
}
