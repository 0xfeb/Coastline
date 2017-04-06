//
//  AttributeString+Attribute.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public extension NSAttributedString {
	public convenience init(str:String, attr:CLAttributes) {
		self.init(string: str, attributes: attr.dict)
	}
}

// 文本属性
public class CLAttributes {
	public enum LineWidth:Int {
		case none = 0x00
		case single = 0x01
		case thick = 0x02
		case double = 0x09
	}
	
	public enum LineStyle:Int {
		case solid = 0x000
		case dot = 0x0100
		case dash = 0x0200
		case dashDot = 0x0300
		case dashDotDot = 0x0400
	}
	
	public var font:UIFont?
	public var textColor:UIColor?
	public var backColor:UIColor?
	public var ligature:Bool?  //连体符
	public var kern:CGFloat?   //字间距
	public var strikethrough:(LineWidth, LineStyle, UIColor)?  //删除线
	public var underline:(LineWidth, LineStyle, UIColor)?      //下划线
	public var textStroke:(CGFloat, UIColor)?      //文字描边
	public var shadow:NSShadow?
	public var attachment:NSTextAttachment?        //附件
	public var baseline:CGFloat?                   //基线
	public var expansion:CGFloat?                  //横向拉伸
	public var link:URL?         //外链
	public var obliqueness:CGFloat?    //倾斜度,+右,-左
	public var vertical:Bool?      //竖排文本
	
	public var alignment:NSTextAlignment?
	public var firstLineHeadIndent:CGFloat?
	public var headIndent:CGFloat?
	public var tailIndent:CGFloat?
	public var lineBreakMode:NSLineBreakMode?
	public var maximumLineHeight:CGFloat?
	public var minimumLineHeight:CGFloat?
	public var lineSpacing:CGFloat?
	public var paragraphSpacing:CGFloat?
	public var paragraphSpacingBefore:CGFloat?
	public var baseWritingDirection:NSWritingDirection?
	public var lineHeightMultiple:CGFloat?
	public var defaultTabInterval:CGFloat?
	
	public init() {
	}
	
	public init(image:UIImage, size:CGSize?) {
		attachment = NSTextAttachment()
		attachment?.image = image
		if let size = size {
			attachment?.bounds = CGRect(origin: .zero, size: size)
		} else {
			let imageSize = image.size
			let drawSize = CGSize(width:imageSize.width/UIScreen.main.scale, height:imageSize.height/UIScreen.main.scale)
			attachment?.bounds = CGRect(origin: .zero, size: drawSize)
		}
	}
	
	// 将文本属性生成系统所属的字典
	public var dict:[String:AnyObject] {
		get{
			var result:[String:AnyObject] = [:]
			if let font = self.font { result[NSFontAttributeName] = font }
			if let textColor = self.textColor { result[NSForegroundColorAttributeName] = textColor }
			if let backColor = self.backColor { result[NSBackgroundColorAttributeName] = backColor }
			if let ligature = self.ligature { result[NSLigatureAttributeName] = NSNumber(value: ligature ? 1:0 as Int) }
			if let kern = self.kern { result[NSKernAttributeName] = NSNumber(value: Float(kern) as Float) }
			if let strikethrough = self.strikethrough {
				result[NSUnderlineColorAttributeName] = strikethrough.2
				result[NSUnderlineStyleAttributeName] = NSNumber(value: strikethrough.0.rawValue + strikethrough.1.rawValue as Int)
			}
			if let underline = self.underline {
				result[NSUnderlineColorAttributeName] = underline.2
				result[NSUnderlineStyleAttributeName] = NSNumber(value: underline.0.rawValue + underline.1.rawValue as Int)
			}
			if let textStroke = self.textStroke {
				result[NSStrokeWidthAttributeName] = NSNumber(value: Float(textStroke.0) as Float)
				result[NSStrokeColorAttributeName] = textStroke.1
			}
			if let shadow = self.shadow { result[NSShadowAttributeName] = shadow }
			if let attachment = self.attachment { result[NSAttachmentAttributeName] = attachment }
			if let baseline = self.baseline { result[NSBaselineOffsetAttributeName] = NSNumber(value: Float(baseline) as Float) }
			if let expansion = self.expansion { result[NSExpansionAttributeName] = NSNumber(value: Float(expansion) as Float) }
			if let link = self.link { result[NSLinkAttributeName] = link as AnyObject? }
			if let obliqueness = self.obliqueness { result[NSObliquenessAttributeName] = obliqueness as AnyObject? }
			if let vertical = self.vertical { result[NSVerticalGlyphFormAttributeName] = NSNumber(value: vertical ? 1:0 as Int) }
			var style:NSMutableParagraphStyle? = nil
			if let alignment = self.alignment {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.alignment = alignment
			}
			if let firstLineHeadIndent = self.firstLineHeadIndent {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.firstLineHeadIndent = firstLineHeadIndent
			}
			if let headIndent = self.headIndent {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.headIndent = headIndent
			}
			if let tailIndent = self.tailIndent {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.tailIndent = tailIndent
			}
			if let lineBreakMode = self.lineBreakMode {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.lineBreakMode = lineBreakMode
			}
			if let maximumLineHeight = self.maximumLineHeight {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.maximumLineHeight = maximumLineHeight
			}
			if let minimumLineHeight = self.minimumLineHeight {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.minimumLineHeight = minimumLineHeight
			}
			if let lineSpacing = self.lineSpacing {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.lineSpacing = lineSpacing
			}
			if let paragraphSpacing = self.paragraphSpacing {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.paragraphSpacing = paragraphSpacing
			}
			if let paragraphSpacingBefore = self.paragraphSpacingBefore {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.paragraphSpacingBefore = paragraphSpacingBefore
			}
			if let baseWritingDirection = self.baseWritingDirection {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.baseWritingDirection = baseWritingDirection
			}
			if let lineHeightMultiple = self.lineHeightMultiple {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.lineHeightMultiple = lineHeightMultiple
			}
			if let defaultTabInterval = self.defaultTabInterval {
				if nil == style { style = NSMutableParagraphStyle() }
				style?.defaultTabInterval = defaultTabInterval
			}
			if let style = style { result[NSParagraphStyleAttributeName] = style }
			
			return result
		}
	}
	
	// 合成新的属性
	func combine(_ attr:CLAttributes) -> CLAttributes {
		if let font = attr.font { self.font = font }
		if let textColor = attr.textColor { self.textColor = textColor }
		if let backColor = attr.backColor { self.backColor = backColor }
		if let ligature = attr.ligature { self.ligature = ligature }
		if let kern = attr.kern { self.kern = kern }
		if let strikethrough = attr.strikethrough { self.strikethrough = strikethrough }
		if let underline = attr.underline { self.underline = underline }
		if let textStroke = attr.textStroke { self.textStroke = textStroke }
		if let shadow = attr.shadow { self.shadow = shadow }
		if let attachment = attr.attachment { self.attachment = attachment }
		if let baseline = attr.baseline { self.baseline = baseline }
		if let expansion = attr.expansion { self.expansion = expansion }
		if let link = attr.link { self.link = link }
		if let obliqueness = attr.obliqueness { self.obliqueness = obliqueness }
		if let vertical = attr.vertical { self.vertical = vertical }
		if let alignment = attr.alignment { self.alignment = alignment }
		if let firstLineHeadIndent = attr.firstLineHeadIndent { self.firstLineHeadIndent = firstLineHeadIndent }
		if let headIndent = attr.headIndent { self.headIndent = headIndent }
		if let tailIndent = attr.tailIndent { self.tailIndent = tailIndent }
		if let lineBreakMode = attr.lineBreakMode { self.lineBreakMode = lineBreakMode }
		if let maximumLineHeight = attr.maximumLineHeight { self.maximumLineHeight = maximumLineHeight }
		if let minimumLineHeight = attr.minimumLineHeight { self.minimumLineHeight = minimumLineHeight }
		if let lineSpacing = attr.lineSpacing { self.lineSpacing = lineSpacing }
		if let paragraphSpacing = attr.paragraphSpacing { self.paragraphSpacing = paragraphSpacing }
		if let paragraphSpacingBefore = attr.paragraphSpacingBefore { self.paragraphSpacingBefore = paragraphSpacingBefore }
		if let baseWritingDirection = attr.baseWritingDirection { self.baseWritingDirection = baseWritingDirection }
		if let lineHeightMultiple = attr.lineHeightMultiple { self.lineHeightMultiple = lineHeightMultiple }
		if let defaultTabInterval = attr.defaultTabInterval { self.defaultTabInterval = defaultTabInterval }
		
		return self
	}
	
	static public func + (attr0:CLAttributes, attr1:CLAttributes) -> CLAttributes {
		return attr0.combine(attr1)
	}
}
