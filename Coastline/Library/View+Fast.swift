//
//  View+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIView {
	func removeSubviews() {
		subviews.forEach{ $0.removeFromSuperview() }
	}
	
	func animation(_ duration:TimeInterval, action:@escaping ()->(), completion:((Bool)->())? = { _ in } ) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: duration, animations: {
            action()
            self.layoutIfNeeded()
            }, completion: completion)
    }
	
	var capture: UIImage? {
		let layer = self.layer
		UIGraphicsBeginImageContextWithOptions(self.frame.size, true, 0.0)
		layer.render(in: UIGraphicsGetCurrentContext()!)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
}
