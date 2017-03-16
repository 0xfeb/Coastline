//
//  UIApplication+Version.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/9/24.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit
import CoreTelephony

public extension UIApplication {
	private static let LAST_VERSION_KEY = "lastVersion"
	private static let LAST_BUILD_KEY = "lastBuild"
	
	// 将当前版本设为最新版本
	public func saveCurrentAsNewVersion() {
		if let version = self.appVersion {
			OperationQueue().addOperation({
				let ud = UserDefaults.standard
				ud.setValue(version, forKey: UIApplication.LAST_VERSION_KEY)
				ud.synchronize()
			})
		}
	}
	
	// 检查当前版本是否为最新版本
	public var isNewVersion:Bool {
		let ud = UserDefaults.standard
		if let version = ud.value(forKey: UIApplication.LAST_VERSION_KEY) as? String {
			return version != self.appVersion
		}
		return true
	}
	
	public var isNewBuild:Bool {
		let ud = UserDefaults.standard
		if let version = ud.value(forKey: UIApplication.LAST_BUILD_KEY) as? String {
			return version != (self.appVersion ?? "0") + "_" + (self.buildVerison ?? "0")
		}
		return true
	}
	
	public func saveCurrentAsNewBuild() {
		let version = (self.appVersion ?? "0") + "_" + self.buildVerison!
		OperationQueue().addOperation({
			let ud = UserDefaults.standard
			ud.setValue(version, forKey: UIApplication.LAST_BUILD_KEY)
			ud.synchronize()
		})
	}
	
	public var agentString:String {
		let system = "iOS"
		let sysVersion = systemVersion
		let mVersion = UIDevice.current.name
		let appVersion = self.appVersion
		let buildVersion = self.buildVerison
		let network = networkType
		
		var sysInfo = utsname()
		uname(&sysInfo)
		let machineMirror = Mirror(reflecting: sysInfo.machine)
		let identifier = machineMirror.children.reduce("") { identifier, element in
			guard let value = element.value as? Int8 , value != 0 else { return identifier }
			return identifier + String(UnicodeScalar(UInt8(value)))
		}
		let model = identifier //UIDevice.current.model
		
		return "\(system);\(sysVersion);\(mVersion);\(appVersion!);\(buildVersion!);\(network);\(model);"
	}
	
	public var networkType:String {
		let ni = CTTelephonyNetworkInfo()
		return ni.currentRadioAccessTechnology ?? "wifi"
	}
}
