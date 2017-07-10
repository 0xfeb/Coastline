//
//  AttributeString+Html.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/25.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension NSAttributedString {
	public  convenience init?(html:String) {
		let options = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
		               NSCharacterEncodingDocumentAttribute:  String.Encoding.utf8.rawValue] as [String : Any]
		if let data = html.data(using: .utf8, allowLossyConversion: true) {
			try? self.init(data: data, options: options, documentAttributes: nil)
		} else {
			return nil
		}
	}
	
	@available(iOS 9.0, *)
	public convenience init?(rtfUrl:String) {
		let options = [NSDocumentTypeDocumentAttribute : NSRTFTextDocumentType,
		               NSCharacterEncodingDocumentAttribute:  String.Encoding.utf8.rawValue] as [String : Any]
		guard let url = rtfUrl.url else { return nil }
		try? self.init(url: url, options: options, documentAttributes: nil)
	}
	
	@available(iOS 9.0, *)
	public convenience init?(rtfdUrl:String) {
		let options = [NSDocumentTypeDocumentAttribute : NSRTFDTextDocumentType,
		               NSCharacterEncodingDocumentAttribute:  String.Encoding.utf8.rawValue] as [String : Any]
		guard let url = rtfdUrl.url else { return nil }
		try? self.init(url: url, options: options, documentAttributes: nil)
	}
}
