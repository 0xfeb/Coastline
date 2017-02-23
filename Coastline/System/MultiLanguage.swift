//
//  MultiLanguage.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/20.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation

public class MultiLanguage {
	public static var shareInstance:MultiLanguage = { MultiLanguage() }()
	
	var bundle:Bundle?
	
	init() {
		if let path = Bundle.main.path(forResource: langName, ofType: "lproj") {
			bundle = Bundle(path: path)
		}
	}
	
	public var langName:String {
		get {
			let ud = UserDefaults.standard
			if let lang = ud.object(forKey: "cur_lang") as? String {
				return lang
			} else {
				var lang = "Base"
				if let langs = ud.object(forKey: "AppleLanguages") as? [String] , langs.count > 0 {
					if langs[0].hasPrefix("zh") {
						lang = "zh-Hans"
					}
				}
				ud.set(lang, forKey: "cur_lang")
				OperationQueue().addOperation {
					let ud = UserDefaults.standard
					ud.synchronize()
				}
				return lang
			}
		}
		
		set {
			if let path = Bundle.main.path(forResource: langName, ofType: "lproj") {
				bundle = Bundle(path: path)
				
				OperationQueue().addOperation {
					let ud = UserDefaults.standard
					ud.set(newValue, forKey: "cur_lang")
					ud.synchronize()
				}
			}
		}
	}
	
	public func str(key:String) -> String? {
		return bundle?.localizedString(forKey: key, value: nil, table: nil)
	}
	
	public func str(table:String, key:String) -> String? {
		return bundle?.localizedString(forKey: key, value: nil, table: table)
	}
	
	public func storyboard(name:String) -> UIStoryboard {
		return UIStoryboard(name: name, bundle: bundle)
	}
}

public extension String {
	var l:String {
		return NSLocalizedString(self, comment: self)
	}
}
