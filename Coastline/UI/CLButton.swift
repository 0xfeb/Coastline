//
//  CLButton.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/5/11.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public class CLButton : UIButton {
	public enum `Type` : Int {
		case leftImage = 0
		case rightImage = 1
		case topImage = 2
		case bottomImage = 3
	}
	
	public var gapBetweenImageText:CGFloat = 4.0
	public var type:Type = .leftImage
	@IBInspectable public var showSize:CGSize = CGSize()
	@IBInspectable public var L0R1T2B3ImagePos:Int  {
		get {
			return type.rawValue
		}
		set {
			type = Type(rawValue: newValue) ?? .leftImage
		}
	}
	
	public var defaultFont:UIFont?
	public override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		titleLabel?.textAlignment = .center
		imageView?.contentMode = .scaleAspectFit
		
		defaultFont = self.titleLabel?.font
		
		setNeedsDisplay()
		setNeedsLayout()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
		guard let image = image(for: .normal), let text = title(for: .normal), let font = defaultFont else { return contentRect }
		
		
		let imageSize = self.showSize.width == 0 ? image.size : showSize
		let textSize = text.textSize(font)
		let gapMixX = (contentRect.width - imageSize.width - textSize.width - gapBetweenImageText) / 2
		let gapMixY = (contentRect.height - imageSize.height - textSize.height - gapBetweenImageText) / 2
		//let gapImgX = (contentRect.width - imageSize.width) / 2
		//let gapImgY = (contentRect.height - imageSize.height) / 2
		let gapTextX = (contentRect.width - textSize.width) / 2
		let gapTextY = (contentRect.height - textSize.height) / 2
		
		switch type {
		case .leftImage:
			return CGRect(x:gapMixX + imageSize.width + gapBetweenImageText, y:gapTextY, width:textSize.width, height:textSize.height)
		case .rightImage:
			return CGRect(x:gapMixX, y:gapTextY, width:textSize.width, height:textSize.height)
		case .topImage:
			return CGRect(x:gapTextX, y:gapMixY + imageSize.height + gapBetweenImageText, width:textSize.width, height:textSize.height)
		case .bottomImage:
			return CGRect(x:gapTextX, y:gapMixY, width:textSize.width, height:textSize.height)
		}
	}
	
	public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		guard let image = image(for: .normal), let text = title(for: .normal), let font = defaultFont else { return contentRect }
		
		let imageSize = self.showSize.width == 0 ? image.size : showSize
		let textSize = text.textSize(font)
		let gapMixX = (contentRect.width - imageSize.width - textSize.width) / 2
		let gapMixY = (contentRect.height - imageSize.height - textSize.height) / 2
		let gapImgX = (contentRect.width - imageSize.width) / 2
		let gapImgY = (contentRect.height - imageSize.height) / 2
		//let gapTextX = (contentRect.width - textSize.width) / 2
		//let gapTextY = (contentRect.height - textSize.height) / 2
		
		switch type {
		case .leftImage:
			return CGRect(x:gapMixX, y:gapImgY, width:imageSize.width, height:imageSize.height)
		case .rightImage:
			return CGRect(x:gapMixX + textSize.width + gapBetweenImageText, y:gapImgY, width:imageSize.width, height:imageSize.height)
		case .topImage:
			return CGRect(x:gapImgX, y:gapMixY, width:imageSize.width, height:imageSize.height)
		case .bottomImage:
			return CGRect(x:gapImgX, y:gapMixY + textSize.height + gapBetweenImageText, width:imageSize.width, height:imageSize.height)
		}
	}
}

