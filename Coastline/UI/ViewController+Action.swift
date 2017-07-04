//
//  ViewController+Action.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/7/4.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIViewController {
	public func run(_ action:@escaping (UIViewController)->(), completion:@escaping (UIViewController)->() = {_ in }) {
		OperationQueue().addOperation { [weak self] in
			guard let vc = self else { return }
			action(vc)
			OperationQueue.main.addOperation { [weak vc] in
				guard let vc = vc else { return }
				completion(vc)
			}
		}
	}
}
