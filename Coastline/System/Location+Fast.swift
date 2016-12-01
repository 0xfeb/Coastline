//
//  Location+Fast.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import CoreLocation

//TODO: 未能获得地理位置信息
public extension CLLocation {
	//获取当前的地理位置
	func getPlace(_ response:@escaping (CLPlacemark?)->()) {
		let coder = CLGeocoder()
		coder.reverseGeocodeLocation(self, completionHandler: { (places:[CLPlacemark]?, err:Error?) in
			response(places?.first)
			})
	}
}

public extension CLPlacemark {
	//将地理位置转换为字符串
	func placeString() -> String {
		var result:String = ""
		if let country = self.country {
			result += country + " "
		}
		
		if let administrativeArea = self.administrativeArea {
			result += administrativeArea + " "
		}
		
		if let subAdministrativeArea = self.subAdministrativeArea {
			result += subAdministrativeArea + " "
		}
		
		if let locality = self.locality {
			result += locality + " "
		}
		
		if let subLocality = self.subLocality {
			result += subLocality + " "
		}
		
		if let thoroughfare = self.thoroughfare {
			result += thoroughfare + " "
		}
		
		if let subThoroughfare = self.subThoroughfare {
			result += subThoroughfare
		}
		
		return result
	}
}
