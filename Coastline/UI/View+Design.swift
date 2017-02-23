//
//  View+Design.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIView {
	@IBInspectable var borderWidth:CGFloat {
		set { self.layer.borderWidth = newValue }
		get { return self.layer.borderWidth }
	}
	
	@IBInspectable var boarderColor:UIColor {
		set { self.layer.borderColor = newValue.cgColor }
		get {
			guard let c = self.layer.borderColor else { return UIColor.black }
			return UIColor(cgColor: c)
		}
	}
	
	@IBInspectable var clipMask:Bool {
		set { self.layer.masksToBounds = newValue }
		get { return self.layer.masksToBounds }
	}
	
	@IBInspectable var cornerRadius:CGFloat {
		set { self.layer.cornerRadius = newValue }
		get { return self.layer.cornerRadius }
	}
	
	@IBInspectable var shadowOpacity:CGFloat {
		set { self.layer.shadowOpacity = Float(newValue) }
		get { return CGFloat(self.layer.shadowOpacity) }
	}
	
	@IBInspectable var shadowRadius:CGFloat {
		set { self.layer.shadowRadius = newValue }
		get { return self.layer.shadowRadius }
	}
	
	@IBInspectable var shadowOffset:CGSize {
		set { self.layer.shadowOffset = newValue }
		get { return self.layer.shadowOffset }
	}
	
	@IBInspectable var shadowColor:UIColor {
		set { self.layer.shadowColor = newValue.cgColor }
		get {
			guard let c = self.layer.shadowColor else { return UIColor.black }
			return UIColor(cgColor: c)
		}
	}
	
}
