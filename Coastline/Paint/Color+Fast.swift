//
//  Color+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIColor {
	convenience init(_ red:Int, _ green:Int, _ blue:Int, _ alpha:Int = 255) {
		self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
	}
	
	convenience init(hex:String) {
		let colorText = hex.hasPrefix("#") ? hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1)) : hex
		
		let red = Int(hex:colorText[0..<2])
		let green = Int(hex:colorText[2..<4])
		let blue = Int(hex:colorText[4..<6])
		
		self.init(red, green, blue)
	}
	
	var RGB:(Int, Int, Int) {
		var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0, white:CGFloat = 0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return (Int(Double(red)*255.0), Int(Double(green)*255.0), Int(Double(blue)*255))
		} else if self.getWhite(&white, alpha: &alpha) {
			let color = Int(Double(white)*255.0)
			return (color, color, color)
		} else {
			return (0, 0, 0)
		}
	}
	
	func darker(_ level:CGFloat) -> UIColor {
		let (red,green,blue) = self.RGB
		let _red = max(min(CGFloat(red) * level, 255.0), 0)
		let _green = max(min(CGFloat(green) * level, 255.0), 0)
		let _blue = max(min(CGFloat(blue) * level, 255.0), 0)
		return UIColor(red: _red/255, green: _green/255, blue: _blue/255, alpha: 1)
	}
	
	func mixed(color:UIColor) -> UIColor {
		let (red,green,blue) = self.RGB
		let (red1,green1,blue1) = color.RGB
		return UIColor((red+red1)/2, (green+green1)/2, (blue+blue1)/2)
	}
}
