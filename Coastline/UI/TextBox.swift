//
//  TextBox.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/5/26.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

/// 文本框, 用于快速计算高度
public class CLTextBox: UIView {
	public var font:UIFont?
	public var text:String?
	public var textColor:UIColor?
	public var aligment:NSTextAlignment?
	public var kern:CGFloat = 0.5
	
	public func setTextGetHeight(text:String?) -> CGFloat {
		self.text = text
		self.setNeedsDisplay()
		
		if let text = text {
			return text.textRectInSize(self.frame.size, font: font ?? UIFont.systemFont(ofSize: 14), wordwarp: .byCharWrapping, kern:kern).height
		} else {
			return 20.0
		}
	}
	
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	public override func draw(_ rect: CGRect) {
		// Drawing code
		let attr = CLAttributes()
		attr.font = font
		attr.textColor = textColor
		attr.lineBreakMode = .byCharWrapping
		attr.alignment = aligment
		attr.kern = kern
		text?.drawInRect(rect, attr: attr.dict)
	}
}

