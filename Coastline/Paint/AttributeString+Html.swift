//
//  AttributeString+Html.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension NSAttributedString {
	public  static func fromHtml(_ html:String) -> NSAttributedString? {
		let options = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
		               NSCharacterEncodingDocumentAttribute:  String.Encoding.utf8.rawValue] as [String : Any]
		if let data = html.data(using: .utf8, allowLossyConversion: true) {
			do {
				return try NSAttributedString(data: data, options: options, documentAttributes: nil)
			} catch {
				print(error)
				return nil
			}
		}
		return nil
	}
}
