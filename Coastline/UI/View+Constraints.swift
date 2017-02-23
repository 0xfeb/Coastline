//
//  View+Constraints.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/2/11.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public class CLViewWithAttribute {
	weak var view:UIView?
	var attribute:NSLayoutAttribute
	
	init(view:UIView, attribute:NSLayoutAttribute) {
		self.view = view
		self.attribute = attribute
	}
	
	func equal(_ attr:CLViewWithAttribute, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0) -> NSLayoutConstraint?  {
		guard let view = view, let aview = attr.view else { return nil }
		let c = NSLayoutConstraint(item: view, attribute: self.attribute, relatedBy: NSLayoutRelation.equal, toItem: aview, attribute: attr.attribute, multiplier: multiplier, constant: constant)
		c.isActive = true
		return c
	}
	
	func equalLess(_ attr:CLViewWithAttribute, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0) -> NSLayoutConstraint?  {
		guard let view = view, let aview = attr.view else { return nil }
		let c = NSLayoutConstraint(item: view, attribute: self.attribute, relatedBy: NSLayoutRelation.lessThanOrEqual, toItem: aview, attribute: attr.attribute, multiplier: multiplier, constant: constant)
		c.isActive = true
		return c
	}
	
	func equalGreater(_ attr:CLViewWithAttribute, constant:CGFloat = 0.0, multiplier:CGFloat = 1.0) -> NSLayoutConstraint?  {
		guard let view = view, let aview = attr.view else { return nil }
		let c = NSLayoutConstraint(item: view, attribute: self.attribute, relatedBy: NSLayoutRelation.greaterThanOrEqual, toItem: aview, attribute: attr.attribute, multiplier: multiplier, constant: constant)
		c.isActive = true
		return c
	}
}

public extension UIView {
	public func layout(_ attr:NSLayoutAttribute) -> CLViewWithAttribute {
		return CLViewWithAttribute(view: self, attribute: attr)
	}
	
	public var l_left:CLViewWithAttribute { return layout(.left) }
	public var l_right:CLViewWithAttribute { return layout(.right) }
	public var l_top:CLViewWithAttribute { return layout(.top) }
	public var l_bottom:CLViewWithAttribute { return layout(.bottom) }
	public var l_leading:CLViewWithAttribute { return layout(.leading) }
	public var l_trailing:CLViewWithAttribute { return layout(.trailing) }
	public var l_width:CLViewWithAttribute { return layout(.width) }
	public var l_height:CLViewWithAttribute { return layout(.height) }
	public var l_centerX:CLViewWithAttribute { return layout(.centerX) }
	public var l_centerY:CLViewWithAttribute { return layout(.centerY) }
	public var l_lastBaseline:CLViewWithAttribute { return layout(.lastBaseline) }
	public var l_firstBaseline:CLViewWithAttribute { return layout(.firstBaseline) }
	public var l_leftMargin:CLViewWithAttribute { return layout(.leftMargin) }
	public var l_rightMargin:CLViewWithAttribute { return layout(.rightMargin) }
	public var l_topMargin:CLViewWithAttribute { return layout(.topMargin) }
	public var l_trailingMargin:CLViewWithAttribute { return layout(.trailingMargin) }
	public var l_bottomMargin:CLViewWithAttribute { return layout(.bottomMargin) }
	public var l_leadingMargin:CLViewWithAttribute { return layout(.leadingMargin) }
	public var l_centerXWithinMargins:CLViewWithAttribute { return layout(.centerXWithinMargins) }
	public var l_centerYWithinMargins:CLViewWithAttribute { return layout(.centerYWithinMargins) }
	public var l_notAnAttribute:CLViewWithAttribute { return layout(.notAnAttribute) }
}
