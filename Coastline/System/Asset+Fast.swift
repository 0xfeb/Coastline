//
//  Asset.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/21.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Photos

public extension PHAsset {
	//从资源获得针对尺寸的图片
	public func imageBySize(_ size:CGSize) -> UIImage? {
		let scale = UIScreen.main.scale
		let size = CGSize(width: size.width*scale, height: size.height*scale)
		
		let manager = PHImageManager.default()
		let option = PHImageRequestOptions()
		var thumbnail:UIImage?
		option.isSynchronous = true
		option.isNetworkAccessAllowed = true
		option.version = .current
		option.deliveryMode = .fastFormat
		manager.requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
			thumbnail = result
		})
		return thumbnail
	}
	
	//从资源获得图片
    public var image:UIImage? {
		let manager = PHImageManager.default()
		let option = PHImageRequestOptions()
		var image:UIImage? = nil
		option.isSynchronous = true
		option.isNetworkAccessAllowed = true
		option.version = .current
		option.deliveryMode = .fastFormat
		manager.requestImageData(for: self, options: option) { (data, _, _, _) in
			if let data = data {
				image = UIImage(data: data)
			}
		}
		return image
	}
}



public extension PHAssetCollection {
	static let AssetTitles = [
		"Slo-mo":"慢动作",
		"Recently Added":"最近添加",
		"Favorites":"最爱",
		"Recently Deleted":"最近删除",
		"Videos":"视频",
		"All Photos":"所有照片",
		"Selfies":"自拍",
		"Screenshots":"屏幕快照"
	]
	
	static func localTitle(_ name:String) -> String {
		return PHAssetCollection.AssetTitles[name] ?? name
	}
	
	//获取相册列表
	static func albums(_ skipNames:[String] = ["Slo-mo", "Videos", "Recently Deleted"]) -> [PHAssetCollection] {
		let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
		let sSmartAlbums = (0..<smartAlbums.count).map{ smartAlbums.object(at: $0) }.filter{ !skipNames.contains($0.localizedTitle!) }
		
		let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: nil)
		let sAlbums = (0..<albums.count).map{ albums.object(at: $0) }
		
		return sSmartAlbums + sAlbums
	}
	
	//从相册中获取资源
	func assets(_ ascending:Bool = false) -> [PHAsset] {
		let options = PHFetchOptions()
		options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]
		
		let assets = PHAsset.fetchAssets(in: self, options: options)
		return (0..<assets.count).map{ assets.object(at: $0) }
	}
}

