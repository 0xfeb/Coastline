//
//  DeviceId.swift
//  VPNGo
//
//  Created by 王渊鸥 on 2016/12/6.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import KeychainAccess

/// 设备唯一ID
public class DeviceId {
	public func readFromStorage() -> String? {
		let ud = UserDefaults.standard
		return ud.string(forKey: "inappkey4")
	}
	
	public func saveToStorage(deviceId:String) {
		OperationQueue().addOperation {
			let ud = UserDefaults.standard
			ud.set(deviceId, forKey: "inappkey4")
			ud.synchronize()
		}
	}
	
	public func readFromKeyChain() -> String? {
		let kc = Keychain(service: "com.lez.vpngo")
		if let key = try? kc.getString("inappkey4") {
			return key
		}
		return nil
	}
	
	public func saveToKeyChain(deviceId:String) {
		OperationQueue().addOperation {
			let kc = Keychain(service: "com.lez.vpngo")
			try? kc.set(deviceId, key: "inappkey4")
		}
	}
	
	/// 这是对外的功能, 通过这个函数, 即可获得一个接近于完美的设备唯一ID
	public func udid() -> String {
		if let sd = readFromStorage() {
			saveToKeyChain(deviceId: sd)
			return sd
		}
		
		if let sd = readFromKeyChain() {
			saveToStorage(deviceId: sd)
			return sd
		}
		
		let sd = String.UUID
		saveToStorage(deviceId: sd)
		saveToKeyChain(deviceId: sd)
		return sd
	}
}
