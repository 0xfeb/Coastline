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
		backView.backgroundColor = UIColor(r:10, g:10, b:10, a:50)
		self.view.addSubview(backView)
		_ = self.view.addConstaint(view: backView, insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
		backView.addSubview(up)
		backView.addSubview(down)
		up.removeConstraints(up.constraints)
		down.removeConstraints(down.constraints)
		let csUp = backView.addConstaint(view: up, outSide: .minYEdge, offset: 0, size: up.bounds.size)
		let csDown = backView.addConstaint(view: down, outSide: .maxYEdge, offset: 0, size: down.bounds.size)
		
		up.layoutIfNeeded()
		down.layoutIfNeeded()
		
		UIView.animate(withDuration: time, animations: { 
			backView.removeConstraints(csUp)
			backView.removeConstraints(csDown)
			_ = backView.addConstaint(view: up, center: CGPoint(x:0, y:up.bounds.size.height / 2 - 100), size: up.bounds.size)
			_ = backView.addConstaint(view: down, center: CGPoint(x:0, y: 0 - down.bounds.size.height / 2 - 80), size: down.bounds.size)
			
			up.layoutIfNeeded()
			down.layoutIfNeeded()
		}, completion: { _ in
			complete()
		})
	}
	
	public func openView(up:UIView, down:UIView, time:TimeInterval, complete:@escaping ()->Void) {
		guard let backView = up.superview else { return }
		UIView.animate(withDuration: time, animations: {
			backView.removeConstraints(backView.constraints)
			_ = self.view.addConstaint(view: backView, insets: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0))
			
			_ = backView.addConstaint(view: up, outSide: .minYEdge, offset: 0, size: up.bounds.size)
			_ = backView.addConstaint(view: down, outSide: .maxYEdge, offset: 0, size: down.bounds.size)
			
			up.layoutIfNeeded()
			down.layoutIfNeeded()
		}, completion: { _ in
			backView.removeFromSuperview()
			complete()
		})
	}
}
