//
//  NavigationController+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension UINavigationController {
	func push(_ viewControllers:[UIViewController], animation:Bool) {
		OperationQueue.main.addOperation {
			let currentLink = self.viewControllers + viewControllers
			self.setViewControllers(currentLink, animated: true)
		}
	}
	
	func pop(_ level:Int = 0) {
		OperationQueue.main.addOperation {
			if level == 0 || level == 1 {
				self.popViewController(animated: true)
			} else {
				let vc = self.viewControllers.reversed()[level-1]
				self.popToViewController(vc, animated: true)
			}
		}
	}
}

