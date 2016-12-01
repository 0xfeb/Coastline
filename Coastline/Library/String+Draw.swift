//
//  String+Draw.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension String {
	// 获取字符串的尺寸(单行)
	func textSize(_ font:UIFont) -> CGSize {
		return (self as NSString).size(attributes: [NSFontAttributeName:font])
	}
	
	// 获取字符串的尺寸(多行)
	func textRectInSize(_ size:CGSize, font:UIFont, wordwarp:NSLineBreakMode) -> CGRect {
		let maxSize = CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude)
		let pStyle = NSMutableParagraphStyle()
		pStyle.lineBreakMode = wordwarp
		let rect = (self as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName:font, NSParagraphStyleAttributeName:pStyle], context: nil)
		return CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height+1)
	}
	
	// 绘制字符串
	func drawInRect(_ rect:CGRect, attr:[String:AnyObject]) {
		(self as NSString).draw(in: rect, withAttributes: attr)
	}
}
