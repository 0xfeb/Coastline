//
//  BezierPath+Sharp.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/4/6.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIBezierPath {
	public enum Sharp {
		case triUp
		case triDown
		case triLeft
		case triRight
		case rect
		case diamond4
		case diamond5
		case cycle
		case pantagon
		case hexagonH
		case hexagonV
		case star4
		case star5
		case arrowUp
		case arrowDown
		case arrowLeft
		case arrowRight
		case directUp
		case directDown
		case directLeft
		case directRight
	}
	
//	public static func symbol(sharp:Sharp, inRect:CGRect, controlOffset:CGFloat?, controlWidth:CGFloat?) -> UIBezierPath {
//		switch sharp {
//		case .triUp:
//			let p = UIBezierPath()
//			p.move(inRect.left, inRect.bottom)
//				.line(inRect.centerH, inRect.top)
//				.line(inRect.right, inRect.bottom)
//				.close()
//			return p
//		case .triDown:
//			let p = UIBezierPath()
//			p.move(inRect.left, inRect.top)
//				.line(inRect.centerH, inRect.bottom)
//				.line(inRect.right, inRect.top)
//				.close()
//			return p
//		case .triLeft:
//			let p = UIBezierPath()
//			p.move(inRect.left, inRect.centerV)
//				.line(inRect.right, inRect.top)
//				.line(inRect.right, inRect.bottom)
//				.close()
//			return p
//		case .triRight:
//			let p = UIBezierPath()
//			p.move(inRect.left, inRect.top)
//				.line(inRect.right, inRect.centerV)
//				.line(inRect.left, inRect.bottom)
//				.close()
//			return p
//		case .rect:
//			return UIBezierPath(rect: inRect)
//		case .cycle:
//			return UIBezierPath(ovalIn: inRect)
//		case .diamond4:
//			let p = UIBezierPath()
//			p.move(inRect.centerH, inRect.top)
//				.line(inRect.right, inRect.centerV)
//				.line(inRect.centerH, inRect.bottom)
//				.line(inRect.left, inRect.centerV)
//				.close()
//			return p
//		}
//	}
}
