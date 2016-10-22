//
//  Sound.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import Foundation
import AudioToolbox

public class CLSound {
	let soundId:SystemSoundID
	
	init(resource:String) {
		let soundResource = URL(fileURLWithPath: resource)
		var _soundId:SystemSoundID = 0
		AudioServicesCreateSystemSoundID(soundResource as CFURL, &_soundId)
		self.soundId = _soundId
	}
	
	func play() {
		AudioServicesPlaySystemSound(soundId)
	}
	
	static func vibrate() {
		AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
	}
}
