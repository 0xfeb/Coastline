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
private class DeviceId {
	public static var shareInstance:DeviceId = { DeviceId() }()
    
    var serviceName:String
    var keyName:String
    
    init() {
        serviceName = UIApplication.shared.bundleId ?? "com.mixbus.coastline"
        keyName = UIApplication.shared.curAppInfo.AppId ?? "deviceid"
    }
	
	private func readFromStorage() -> String? {
		let ud = UserDefaults.standard
		return ud.string(forKey: keyName)
	}
	
	private func saveToStorage(deviceId:String) {
		OperationQueue().addOperation { [weak self] in
            guard let vc = self else { return }
			let ud = UserDefaults.standard
			ud.set(deviceId, forKey: vc.keyName)
			ud.synchronize()
		}
	}
	
	private func readFromKeyChain() -> String? {
		let kc = Keychain(service: serviceName)
		if let key = try? kc.getString(keyName) {
			return key
		}
		return nil
	}
	
	private func saveToKeyChain(deviceId:String) {
		OperationQueue().addOperation {  [weak self] in
            guard let vc = self else { return }
			let kc = Keychain(service: vc.serviceName)
			try? kc.set(deviceId, key: vc.keyName)
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

public extension UIApplication {
    public var udid: String {
        return DeviceId.shareInstance.udid()
    }
}
