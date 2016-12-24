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
		vc.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
		vc.view.backgroundColor = UIColor.clear
		self.addChildViewController(vc)
		self.view.addSubview(vc.view)

		UIView.animate(withDuration: time, animations: {
			vc.view.backgroundColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 0.5)
			vc.view.transform = CGAffineTransform.identity
		}) { (_) in
			complete()
		}
	}
	
	public func unPopOut(time:TimeInterval, complete:@escaping ()->Void) {
		self.view.backgroundColor = UIColor.clear
		UIView.animate(withDuration: time, animations: { [weak self] in
			self?.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
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
		let window = UIApplication.shared.delegate?.window
		window!?.addSubview(iView)
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
		let window = UIApplication.shared.delegate?.window
		window!?.addSubview(iView)
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
}
