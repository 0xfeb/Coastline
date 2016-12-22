//
//  AlertController+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIAlertController {
	convenience init(_ title:String) {
		self.init(title: title, message:nil, preferredStyle:.alert)
	}
	
	convenience init(forActionSheet title:String) {
		self.init(title: title, message:nil, preferredStyle: .actionSheet)
	}
	
	func add(_ button:String, _ event:@escaping ()->Void = { _ in }) -> UIAlertController {
		let action = UIAlertAction(title: button, style: .default, handler: { _ in event()})
		self.addAction(action)
		return self
	}
	
	func add(cancel button:String, _ event:@escaping ()->Void = { _ in }) -> UIAlertController {
		let action = UIAlertAction(title: button, style: .cancel) { _ in
			event()
		}
		self.addAction(action)
		return self
	}
	
	func add(destruct button:String, _ event:@escaping ()->Void = { _ in }) -> UIAlertController {
		let action = UIAlertAction(title: button, style: .destructive) { _ in
			event()
		}
		self.addAction(action)
		return self
	}
	
	func show(_ viewController:UIViewController?) {
		guard let viewController = viewController else { return }
		OperationQueue.main.addOperation {
			if let nv = viewController.navigationController {
				nv.present(self, animated: true, completion: nil)
			} else {
				viewController.present(self, animated: true, completion: nil)
			}
		}
	}
}
