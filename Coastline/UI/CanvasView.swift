//
//  CanvasView.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public class CLCanvasView: UIView {
	var drawEvent:(CGRect, CGContext)->() = { _ in }
	
	override public func draw(_ rect: CGRect) {
		if let context = UIGraphicsGetCurrentContext() {
			context.saveGState()
			drawEvent(rect, context)
			context.restoreGState()
		}
	}
}

