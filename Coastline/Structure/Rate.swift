//
//  Rate.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/15.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIDevice {
	public func itemWidthOfRate(refDeviceSize:CGSize, refItemWidth:CGFloat) -> CGFloat {
		let screenSize = UIScreen.main.bounds.size
		return sqrt(pow(refItemWidth, 2) * (pow(screenSize.width, 2) + pow(screenSize.height, 2)) / (pow(refDeviceSize.width, 2) + pow(refDeviceSize.height, 2)))
	}
}
