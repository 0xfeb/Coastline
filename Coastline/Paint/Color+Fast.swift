//
//  Color+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIColor {
	public convenience init(r:Int, g:Int, b:Int, a:Int = 100) {
		self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/100.0)
	}
	
	public convenience init(hex:String) {
		let colorText = hex.hasPrefix("#") ? hex.substring(from: hex.characters.index(hex.startIndex, offsetBy: 1)) : hex
		
		let red = Int(hex:colorText[0..<2])
		let green = Int(hex:colorText[2..<4])
		let blue = Int(hex:colorText[4..<6])
		
		if colorText.characters.count > 6 {
			let alpha = Int(Float(Int(hex:colorText[6..<8])) / 2.55)
			self.init(r: red, g: green, b: blue, a: alpha)
		} else {
			self.init(r: red, g: green, b: blue)
		}
	}
	
	public convenience init(h:Int, s:Int, b:Int, a:Int = 100) {
		self.init(hue: CGFloat(h)/360.0, saturation: CGFloat(s)/100.0, brightness: CGFloat(b)/100.0, alpha: CGFloat(a)/100.0)
	}
	
	public var RGBA:(Int, Int, Int, Int) {
		var red:CGFloat = 0, green:CGFloat = 0, blue:CGFloat = 0, alpha:CGFloat = 0, white:CGFloat = 0
		if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
			return (Int(Double(red)*255.0), Int(Double(green)*255.0), Int(Double(blue)*255), Int(Double(alpha)*100.0))
		} else if self.getWhite(&white, alpha: &alpha) {
			let color = Int(Double(white)*255.0)
			return (color, color, color, Int(Double(alpha)*100.0))
		} else {
			return (0, 0, 0, 0)
		}
	}
	
	public var HSBA:(Int, Int, Int, Int) {
		var h:CGFloat = 0, s:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
		if getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
			return (Int(Double(h)*360.0), Int(Double(s)*100.0), Int(Double(b)*100.0), Int(Double(a)*100.0))
		} else {
			return (0, 0, 0, 0)
		}
	}
	
	public func ligher(_ level:CGFloat) -> UIColor {
		let (h, s, b, a) = HSBA
		let db = Int(level * 100) + b
		let nb = min(max(db, 0), 100)
		return UIColor(h: h, s: s, b: nb, a: a)
	}
	
	public func darker(_ level:CGFloat) -> UIColor {
		return ligher(0 - level)
	}
	
	public func mixed(color:UIColor) -> UIColor {
		let (r,g,b, a) = self.RGBA
		let (r1,g1,b1, a1) = color.RGBA
		return UIColor(r:avg(r, r1).limit(start: 0, end: 255),
		               g:avg(g, g1).limit(start: 0, end: 255),
		               b:avg(b, b1).limit(start: 0, end: 255),
		               a:avg(a, a1).limit(start: 0, end: 100))
	}
	
	public var image:UIImage? {
		return UIImage.colorImage(self)
	}
}
