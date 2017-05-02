//
//  ViewController+Animate.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/12/23.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

public extension UIViewController {
	public func popOut(vc:UIViewController, time:TimeInterval, complete:@escaping ()->Void) {
		vc.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		vc.view.backgroundColor = UIColor.clear
		self.addChildViewController(vc)
		self.view.addSubview(vc.view)

		UIView.animate(withDuration: time, animations: {
			vc.view.transform = CGAffineTransform.identity
		}) { (_) in
			vc.view.backgroundColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 0.5)
			complete()
		}
	}
	
	public func unPopOut(time:TimeInterval, complete:@escaping ()->Void) {
		self.view.backgroundColor = UIColor.clear
		UIView.animate(withDuration: time, animations: { [weak self] in
			self?.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		}) { (_) in
			self.view.removeFromSuperview()
			self.removeFromParentViewController()
			complete()
		}
	}
	
	public func leftIn(vc:UIViewController, time:TimeInterval, complete:@escaping ()->Void) {
		guard let image = vc.view.fastCapture  else { self.present(vc, animated: true) { complete() }; return }
		let iView = UIImageView(image: image)
		iView.frame = CGRect(x: -self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
		self.view.addSubview(iView)
		
		UIView.animate(withDuration: time, animations: { 
			iView.frame = self.view.bounds
		}) { (_ ) in
			self.present(vc, animated: false, completion: { 
				iView.removeFromSuperview()
				complete()
			})
		}
	}
	
	public func unLeftIn(time:TimeInterval, complete:@escaping ()->Void) {
		guard let image = self.view.fastCapture  else { self.dismiss(animated: true){ complete() } ; return }
		let iView = UIImageView(image: image)
		iView.frame = self.view.bounds
		guard let window = UIApplication.shared.delegate?.window else { return }
		window?.addSubview(iView)
		self.dismiss(animated: false) { 
			UIView.animate(withDuration: time, animations: {
				let screenRect = UIScreen.main.bounds
				iView.frame = CGRect(x: -screenRect.width, y: 0, width: screenRect.width, height: screenRect.height)
			}, completion: { (_) in
				iView.removeFromSuperview()
				complete()
			})
		}
	}
	
	public func rightIn(vc:UIViewController, time:TimeInterval, complete:@escaping ()->Void) {
		guard let image = vc.view.fastCapture  else { self.present(vc, animated: true) { complete() }; return }
		let iView = UIImageView(image: image)
		iView.frame = CGRect(x: self.view.bounds.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
		self.view.addSubview(iView)
		
		UIView.animate(withDuration: time, animations: {
			iView.frame = self.view.bounds
		}) { (_ ) in
			self.present(vc, animated: false, completion: {
				iView.removeFromSuperview()
				complete()
			})
		}
	}
	
	public func unRightIn(time:TimeInterval, complete:@escaping ()->Void) {
		guard let image = self.view.fastCapture  else { self.dismiss(animated: true){ complete() } ; return }
		let iView = UIImageView(image: image)
		iView.frame = self.view.bounds
		guard let window = UIApplication.shared.delegate?.window else { return }
		window?.addSubview(iView)
		self.dismiss(animated: false) {
			UIView.animate(withDuration: time, animations: {
				let screenRect = UIScreen.main.bounds
				iView.frame = CGRect(x: screenRect.width, y: 0, width: screenRect.width, height: screenRect.height)
			}, completion: { (_) in
				iView.removeFromSuperview()
				complete()
			})
		}
	}
	
	public func closeView(up:UIView, down:UIView, centerOffsetOfUp:CGFloat, centerOffsetOfDown:CGFloat, time:TimeInterval, complete:@escaping ()->Void) {
		let backView = UIView(frame: self.view.bounds)
		backView.backgroundColor = UIColor(10, 10, 10, 50)
		self.view.addSubview(backView)
		up.frameCenterH = self.view.frameCenterH
		up.frameBottom = 0
		down.frameCenterH = self.view.frameCenterH
		down.frameTop = self.view.bounds.height
		backView.addSubview(up)
		backView.addSubview(down)
		
		backView.
		
		UIView.animate(withDuration: time, animations: { 
			up.frameBottom = self.view.frameCenterV - centerOffsetOfUp
			down.frameTop = self.view.frameCenterV + centerOffsetOfDown
		}, completion: { _ in
			complete()
		})
	}
	
	public func openView(up:UIView, down:UIView, time:TimeInterval, complete:@escaping ()->Void) {
		UIView.animate(withDuration: time, animations: { 
			up.frameBottom = 0
			down.frameTop = self.view.bounds.height
		}, completion: { _ in
			up.superview?.removeFromSuperview()
			complete()
		})
	}
}
