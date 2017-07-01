//
//  KeyboardResult.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/7/1.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

struct KeyboardResult {
	var frameBegin:CGRect?
	var frameEnd:CGRect?
	var animationCurve:UIViewAnimationCurve?
	var animationDuration:CGFloat?
	var isLocal:Bool?
	
	init(_ dict:[AnyHashable:Any]) {
		if let fb = dict[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
			frameBegin = fb.cgRectValue
		}
		
		if let fe = dict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
			frameEnd = fe.cgRectValue
		}
		
		if let ac = dict[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {
			animationCurve = UIViewAnimationCurve(rawValue: ac.intValue)
		}
		
		if let ad = dict[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
			animationDuration = CGFloat(ad.doubleValue)
		}
		
		if #available(iOS 9.0, *) {
			if let il = dict[UIKeyboardIsLocalUserInfoKey] as? NSNumber {
				isLocal = il.boolValue
			}
		} else {
			// Fallback on earlier versions
		}
	}
}
