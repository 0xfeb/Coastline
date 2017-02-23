//
//  Image+File.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIImage {
	func saveToAlbum() {
		UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil)
	}
	
	func pngData() -> Data? {
		return UIImagePNGRepresentation(self)
	}
	
	func jpegData(_ quality:Double) -> Data? {
		return UIImageJPEGRepresentation(self, CGFloat(quality))
	}
	
	func toPngFile(_ path:String) -> Bool {
		let data = pngData()
		return ((try? data?.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil)
	}
	
	func toJpegFile(_ quality:Double, path:String) -> Bool {
		let data = jpegData(quality)
		return ((try? data?.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil)
	}
}
