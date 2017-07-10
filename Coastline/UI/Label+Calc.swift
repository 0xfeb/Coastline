//
//  Label+Calc.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UILabel {
	public var calcedWidth:CGFloat {
		if let text = text {
			return text.textSize(self.font).width
		}
		return 0
	}
	
	public func autoWidthConstraint() {
		if let n = self.constraints.index(where: { $0.firstAttribute == .width })  {
			self.constraints[n].constant = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: self.numberOfLines).width
		}
	}
}
