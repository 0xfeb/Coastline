//
//  SystemConfig.swift
//  DCVideo
//
//  Created by 王渊鸥 on 2017/5/16.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import MediaPlayer
import UIKit

public class CLSystemConfig {
	public static var shareInstance:CLSystemConfig = { CLSystemConfig() }()
	
	var volumeView:MPVolumeView
	var volumeViewSlider:UISlider?
	
	var brightView:CLBrightView = CLBrightView()
	var brightTimer:Timer?
	
	init() {
		volumeView = MPVolumeView()
		
		for v in volumeView.subviews {
			if let v = v as? UISlider {
				volumeViewSlider = v
				break
			}
		}
		
		
		brightView.frame = CGRect(center: UIScreen.main.bounds.center, size: CGSize(width:156, height:156)).move(offset: CGSize(width:0, height:-4))
		brightView.backgroundColor = UIColor.clear
		
	}
	
	public var bright:CGFloat {
		get {
			return UIScreen.main.brightness
		}
		
		set {
			UIScreen.main.brightness = newValue
			
			brightView.setNeedsDisplay()
			
			brightTimer?.invalidate()
			if let window = UIApplication.shared.delegate?.window {
				window?.addSubview(brightView)
				
				brightTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(brightTimerEvent), userInfo: nil, repeats: false)
			}
		}
	}
	
	@objc func brightTimerEvent() {
		brightView.removeFromSuperview()
	}
	
	public var volume:CGFloat {
		get {
			if let s = volumeViewSlider {
				return CGFloat(s.value)
			}
			
			return 0
		}
		
		set {
			if let s = volumeViewSlider {
				s.value = Float(newValue)
			}
		}
	}
}


class CLBrightView : UIView {
	override func draw(_ rect: CGRect) {
		//background
		let br = rect.squreInside()
		let path = UIBezierPath(roundedRect: br, cornerRadius: 8.0)
		let bc = UIColor(colorLiteralRed: 0.85, green: 0.85, blue: 0.85, alpha: 0.9)
		bc.setFill()
		path.fill()
		
		//text
		let attr = CLAttributes()
		if #available(iOS 8.2, *) {
			attr.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
		} else {
			// Fallback on earlier versions
		}
		attr.textColor = UIColor.darkGray
		attr.alignment = NSTextAlignment.center
		let tr = br.inside(.minYEdge, width: 21).move(offset: CGSize(width:0, height:15))
		"亮度".drawInRect(tr, attr: attr.dict)
		
		//sign
		if let image = UIImage(named: "bright") {
			image.draw(in: CGRect(center:br.center, size:image.size))
		}
		
		//bar back
		let bbr = br.inside(.maxYEdge, size: CGSize(width:br.width - 20, height:8)).move(offset: CGSize(width:0, height:45))
		let brpath = UIBezierPath(roundedRect: bbr, cornerRadius: 2.0)
		UIColor.darkGray.setFill()
		brpath.fill()
		
		//bar progress
		let iH = bbr.height - 2
		let iPerWidth = (bbr.width - 17) / 16
		let n = Int(round(UIScreen.main.brightness * 16))
		let c = UIColor.white
		c.setFill()
		(0..<n).forEach{
			let r = CGRect(x:bbr.left + 1 + CGFloat($0) * (iPerWidth + 1), y:bbr.top + 1, width:iPerWidth, height:iH)
			let p = UIBezierPath(roundedRect: r, cornerRadius: 1.0)
			p.fill()
		}
	}
}

