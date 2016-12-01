//
//  Context+Frame.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreText

public extension CGContext {
	func drawFrame(_ frame:CTFrame) {
		CTFrameDraw(frame, self)
	}
}

public extension CTFramesetter {
	class func create(_ str:NSAttributedString) -> CTFramesetter {
		return CTFramesetterCreateWithAttributedString(str)
	}
	
	func suggestSize(_ range:NSRange, size:CGSize) -> (NSRange, CGSize) {
		var retRagen = CFRange(location: 0, length: 0)
		let retSize = CTFramesetterSuggestFrameSizeWithConstraints(self, CFRange(location: range.location, length: range.length), nil, size, &retRagen)
		return (NSRange(location: retRagen.location, length: retRagen.length), retSize)
	}
	
	func suggestPages(_ size:CGSize) -> [(NSRange, CGSize)] {
		var range = NSRange(location: 0, length: 10000)
		var sug = suggestSize(range, size: size)
		var ret:[(NSRange, CGSize)] = []
		while sug.0.length > 0 {
			ret += [sug]
			range = NSRange(location: sug.0.location+sug.0.length, length:10000)
			sug = suggestSize(range, size: size)
		}
		return ret
	}
	
	func suggestFrames(_ size:CGSize) -> [CTFrame] {
		return suggestPages(size).map{
			let path = UIBezierPath()
			return CTFramesetterCreateFrame(self, CFRange(location: $0.0.location, length: $0.0.length), path.cgPath, nil)
		}
	}
	
	func suggestRangerAndFrames(_ size:CGSize) -> [(NSRange, CTFrame)] {
		return suggestPages(size).map{
			let path = UIBezierPath()
			let frame = CTFramesetterCreateFrame(self, CFRange(location: $0.0.location, length: $0.0.length), path.cgPath, nil)
			return ($0.0, frame)
		}
	}
}
