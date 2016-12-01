//
//  AttributeString+Html.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension NSAttributedString {
	// 从html生成字符串
	convenience init?(html:String) {
		let options:[String:AnyObject] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType as AnyObject,
		                                  NSCharacterEncodingDocumentAttribute : NSNumber(value: Int(String.Encoding.utf8.rawValue))]
		if let data = (html as NSString).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: true) {
			do { try self.init(data: data, options: options, documentAttributes: nil)}
			catch { return nil }
		}
		return nil
	}
}
