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
	
	func add(_ button:String, _ event:@escaping ()->Void = { _ in }) {
		let action = UIAlertAction(title: button, style: .default, handler: { _ in event()})
		self.addAction(action)
		//return self
	}
	
	func add(cancel button:String, _ event:@escaping ()->Void = { _ in }) {
		let action = UIAlertAction(title: button, style: .cancel) { _ in
			event()
		}
		self.addAction(action)
	}
	
	func add(destruct button:String, _ event:@escaping ()->Void = { _ in }) {
		let action = UIAlertAction(title: button, style: .destructive) { _ in
			event()
		}
		self.addAction(action)
	}
	
	func show(_ viewController:UIViewController?, barButtonItem:UIBarButtonItem? = nil) {
		guard let viewController = viewController else { return }
		if UIDevice.current.isiPad {
			if let popover = self.popoverPresentationController {
				popover.barButtonItem = barButtonItem
			}
		}
		OperationQueue.main.addOperation {
			if let nv = viewController.navigationController {
				nv.present(self, animated: true, completion: nil)
			} else {
				viewController.present(self, animated: true, completion: nil)
			}
		}
	}
    
    func show(_ viewController:UIViewController?, rect:CGRect, inView:UIView) {
        if let popover = self.popoverPresentationController {
            popover.sourceView = inView
            popover.sourceRect = rect
        }
        OperationQueue.main.addOperation {
            if let nv = viewController?.navigationController {
                nv.present(self, animated: true, completion: nil)
            } else {
                viewController?.present(self, animated: true, completion: nil)
            }
        }
    }
    
    func show(_ viewController:UIViewController?, centerInView view:UIView) {
        return show(viewController, rect:CGRect.init(center: view.bounds.center, size: CGSize(width:320, height:240)), inView:view)
    }
    
    func show(_ viewController:UIViewController?, bellowUnderView view:UIView) {
        let rect = view.frame.outside(.maxYEdge, width: 320)
        return show(viewController, rect:rect, inView:view)
    }
}
