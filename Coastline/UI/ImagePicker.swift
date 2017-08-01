//
//  ImagePicker.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/6/30.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos

public struct ImagePickerResult {
	public enum MediaType : String {
		case image = "image"
		case video = "video"
	}
	
	public var type:MediaType?
	public var original:UIImage?
	public var edited:UIImage?
	public var crop:CGRect?
	public var url:NSURL?
	public var meta:[String:Any]?
	public var livePhoto:Any?
	
    public init(_ dict:[String:Any]) {
		if let mt = dict[UIImagePickerControllerMediaType] as? String {
			type = MediaType(rawValue: mt)
		}
		
		if let oi = dict[UIImagePickerControllerOriginalImage] as? UIImage {
			original = oi
		}
		
		if let ei = dict[UIImagePickerControllerEditedImage] as? UIImage {
			edited = ei
		}
		
		if let c = dict[UIImagePickerControllerCropRect] as? NSValue {
			crop = c.cgRectValue
		}
		
		if let u = dict[UIImagePickerControllerMediaURL] as? NSURL {
			url = u
		}
		
		if let m = dict[UIImagePickerControllerMediaMetadata] as? [String:Any] {
			meta = m
		}
		
        if #available(iOS 9.1, *) {
            if let lp = dict[UIImagePickerControllerLivePhoto] as? PHLivePhoto {
                livePhoto = lp
            }
        } else {
            // Fallback on earlier versions
        }
	}
}
