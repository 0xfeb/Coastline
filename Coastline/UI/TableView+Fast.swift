//
//  TableView+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UITableView {
	public var autoHeight:CGFloat {
		get { return estimatedRowHeight }
		set {
			rowHeight = UITableViewAutomaticDimension
			estimatedRowHeight = newValue
		}
	}
}
