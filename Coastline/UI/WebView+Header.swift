//
//  WebView+Header.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/1/25.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIWebView {
	public func load(_ urlText:String, header:[String:String] = [:]) {
		if var req = urlText.url?.request {
			for kv in header {
				req.setValue(kv.value, forHTTPHeaderField: kv.key)
			}
			
			self.loadRequest(req)
		}
	}
}
