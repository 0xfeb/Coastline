//
//  Choose.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import UIKit
import WebKit

//取得一系列可选对象中存在的对象
public func choose<T>(_ v:T?...) -> T? {
	for n in v {
		if let n = n { return n }
	}
	
	return nil
}


//打包配置一个对象
public func setup<T>(_ item:T, _ action:(T)->Void) -> T {
	action(item)
	return item
}

public extension UIViewController {
	override func setup(_ action: (UIViewController) -> ()) {
		action(self)
	}
}

public extension UIButton {
	override func setup(_ action: (UIButton) -> ()) {
		action(self)
	}
}

public extension UIBezierPath {
	override func setup(_ action: (UIBezierPath) -> ()) {
		action(self)
	}
}

public extension UITextField {
	override func setup(_ action: (UITextField) -> ()) {
		action(self)
	}
}

public extension UITextView {
	override func setup(_ action: (UITextView) -> ()) {
		action(self)
	}
}

public extension UILabel {
	override func setup(_ action: (UILabel) -> ()) {
		action(self)
	}
}

public extension UIBarButtonItem {
	override func setup(_ action: (UIBarButtonItem) -> ()) {
		action(self)
	}
}

public extension UIImagePickerController {
	override func setup(_ action: (UIImagePickerController) -> ()) {
		action(self)
	}
}

public extension UIActivity {
	override func setup(_ action: (UIActivity) -> ()) {
		action(self)
	}
}

public extension WKWebView {
	override func setup(_ action: (WKWebView) -> ()) {
		action(self)
	}
}

public extension UIWebView {
	override func setup(_ action: (UIWebView) -> ()) {
		action(self)
	}
}

public extension UIView {
	override func setup(_ action: (UIView) -> ()) {
		action(self)
	}
}

public extension NSObject {
	func setup(_ action:(NSObject)->()) {
		action(self)
	}
}

