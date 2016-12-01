//
//  Storyboard+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

extension UIStoryboard {
	static var main: UIStoryboard {
		get {
			return UIStoryboard(name: "Main", bundle: nil)
		}
	}
	
	func viewController(_ name:String) -> UIViewController? {
		let vc = self.instantiateViewController(withIdentifier: name)
		return vc
	}
}

extension UIViewController {
	func brotherViewController(_ name:String) -> UIViewController? {
		return storyboard?.viewController(name)
	}
}
