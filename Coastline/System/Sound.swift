//
//  Sound.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import AudioToolbox

//声音处理
public class CLSound {
	let soundId:SystemSoundID
	
	//指定声音的资源, wav/caf/aif文件, 格式为pcm/ima4
	init(resource:String) {
		let soundResource = URL(fileURLWithPath: resource)
		var _soundId:SystemSoundID = 0
		AudioServicesCreateSystemSoundID(soundResource as CFURL, &_soundId)
		self.soundId = _soundId
	}
	
	//播放声音
	func play() {
		AudioServicesPlaySystemSound(soundId)
	}
	
	//震动
	public static func vibrate() {
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
	}
}
