//
//  Image+Color.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit
import CoreImage

public extension UIImage {
	func masked(withColor color:UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, true, 0.0)
		self.draw(at: CGPoint(x: 0.0, y: 0.0))
		color.setFill()
		UIRectFillUsingBlendMode(CGRect(origin: CGPoint.zero, size: self.size), CGBlendMode.sourceAtop)
		let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return result
	}
	
	static func colorImage(_ color:UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 1.0, height: 1.0), false, 0.0)
		color.setFill()
		UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return result
	}
	
	func blur(_ radius:CGFloat) -> UIImage {
		let ci = self.ciImage
		let filter = CIFilter(name: "CIGaussianBlur")
		filter?.setValue(ci!, forKey: kCIInputImageKey)
		filter?.setValue(NSNumber(value: Double(radius) as Double), forKey: "inputRadius")
		let co = filter?.value(forKey: kCIOutputImageKey) as? CoreImage.CIImage
		return UIImage(ciImage: co!)
	}
}
