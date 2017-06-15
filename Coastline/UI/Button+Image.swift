//
//  Button.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIButton {
	static var imageSurfix:(normal:String, selected:String, disable:String) = ("", "_sel", "_dis")
	static var backImageSurfix:(normal:String, selected:String, disable:String) = ("_back", "_backsel", "_backdis")
	
	func useDefaultImage(perfix:String) {
		setImage(UIImage(named: perfix+UIButton.imageSurfix.normal), for: .normal)
		setImage(UIImage(named: perfix+UIButton.imageSurfix.selected), for: .selected)
		setImage(UIImage(named: perfix+UIButton.imageSurfix.disable), for: .disabled)
		
		setBackgroundImage(UIImage(named: perfix+UIButton.backImageSurfix.normal), for: .normal)
		setBackgroundImage(UIImage(named: perfix+UIButton.backImageSurfix.selected), for: .selected)
		setBackgroundImage(UIImage(named: perfix+UIButton.backImageSurfix.disable), for: .disabled)
	}
	
	public func autoWidthConstraint() {
		if let n = self.constraints.index(where: { $0.firstAttribute == .width })  {
			self.constraints[n].constant = self.titleRect(forContentRect: self.contentRect(forBounds: self.bounds)).width
		}
	}
}
