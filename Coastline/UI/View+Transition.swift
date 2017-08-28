//
//  View+Transition.swift
//  Coastline
//
//  Created by 王渊鸥 on 2017/5/13.
//  Copyright © 2017年 王渊鸥. All rights reserved.
//

import UIKit

class TransContainer : NSObject {
	enum AnimationType {
		case presentLeft
		case dismissLeft
		case presentRight
		case dismissRight
		case presentTop
		case dismissTop
		case presentBottom
		case dismissBottom
		case presentScale
		case dismissScale
		case presentBottomScale
		case dismissBottomScale
		case presentPop
		case dismissPop
        case presentCycle
        case dismissCycle
	}
	
	var timeout:TimeInterval = 0.2
	var type:AnimationType = .presentLeft
	var scale:(view:UIView, frame:CGRect)?
	var scaleBottom:(scale:CGFloat, height:CGFloat)?
	var scaleMiddle:(constraint:NSLayoutConstraint, height:CGFloat)?
	var popScale:(scale:CGFloat, color:UIColor)?
    var popCycle:CGRect?
	
	init(_ t:AnimationType, duration:TimeInterval) {
		type = t
		timeout = duration
	}
	
	init(_ t:AnimationType, duration:TimeInterval, scale s:(view:UIView, frame:CGRect)) {
		type = t
		timeout = duration
		scale = s
	}
	
	init(_ t:AnimationType, duration:TimeInterval, scaleBottom s:(scale:CGFloat, height:CGFloat)) {
		type = t
		timeout = duration
		scaleBottom = s
	}
	
	init(_ t:AnimationType, duration:TimeInterval, popScale s:(scale:CGFloat, color:UIColor)) {
		type = t
		timeout = duration
		popScale = s
	}
    
    init(_ t:AnimationType, duration:TimeInterval, cycle:CGRect) {
        type = t
        timeout = duration
        popCycle = cycle
    }
	
	private func itemsFromContext(context:UIViewControllerContextTransitioning) -> (from:UIViewController, to:UIViewController, container:UIView)? {
		guard let from = context.viewController(forKey: UITransitionContextViewControllerKey.from), let to = context.viewController(forKey: UITransitionContextViewControllerKey.to) else { return nil }
		let container = context.containerView
		container.addSubview(to.view)
		
		return (from, to, container)
	}
	
	func animationPresentLeft(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.frame = items.container.bounds.outside(.minXEdge, width: items.container.bounds.width)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.to.view.frame = items.container.bounds
		}) { (finish) in
			items.from.view.isUserInteractionEnabled = true
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationDismissLeft(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.from.view.frame = items.container.bounds.outside(.minXEdge, width: items.container.bounds.width)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentRight(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.frame = items.container.bounds.outside(.maxXEdge, width: items.container.bounds.width)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.to.view.frame = items.container.bounds
		}) { (finish) in
			items.from.view.isUserInteractionEnabled = true
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationDismissRight(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.from.view.frame = items.container.bounds.outside(.maxXEdge, width: items.container.bounds.width)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentTop(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.frame = items.container.bounds.outside(.minYEdge, width: items.container.bounds.height)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.to.view.frame = items.container.bounds
		}) { (finish) in
			items.from.view.isUserInteractionEnabled = true
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationDismissTop(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.from.view.frame = items.container.bounds.outside(.minYEdge, width: items.container.bounds.height)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentBottom(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.frame = items.container.bounds.outside(.maxYEdge, width: items.container.bounds.height)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.to.view.frame = items.container.bounds
		}) { (finish) in
			items.from.view.isUserInteractionEnabled = true
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationDismissBottom(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.from.view.frame = items.container.bounds.outside(.maxYEdge, width: items.container.bounds.height)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentScale(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context), let scale = scale else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.isHidden = true
		let originFrame = scale.view.frame
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						scale.view.frame = scale.frame
		}) { (finish) in
			items.from.view.isUserInteractionEnabled = true
			items.to.view.isHidden = false
			scale.view.frame = originFrame
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationDismissScale(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context), let scale = scale else { return }
		
		let originFrame = scale.view.frame
		scale.view.frame = scale.frame
		items.from.view.isHidden = true
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						scale.view.frame = originFrame
		}) { (finish) in
			items.from.view.removeFromSuperview()
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentBottomScale(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context), let scaleBottom = scaleBottom else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.to.view.frame = items.container.bounds.outside(.maxYEdge, width: items.container.bounds.height)
		UIView.animate(withDuration: transitionDuration(using: context),
		               delay: 0,
		               usingSpringWithDamping: 0.55,
		               initialSpringVelocity: 1 / 0.88,
		               options: [],
		               animations: {
						items.from.view.transform = CGAffineTransform(scaleX: scaleBottom.scale, y: scaleBottom.scale)
						items.to.view.frame = items.container.bounds.inside(.maxYEdge, width: scaleBottom.height)
		}) { (finish) in
			context.completeTransition(!context.transitionWasCancelled)
			
			items.container.insertSubview(items.from.view, belowSubview: items.to.view)
		}
	}
	
	func animationDismissBottomScale(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.to.view.transform = CGAffineTransform.identity
						items.from.view.frame = items.container.bounds.outside(.maxYEdge, width: items.container.bounds.height)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			items.to.view.isUserInteractionEnabled = true
			
			context.completeTransition(!context.transitionWasCancelled)
		}
	}
	
	func animationPresentPop(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context), let popScale = popScale else { return }
		
		let b = UIView(frame: items.container.bounds)
		b.backgroundColor = popScale.color
		b.tag = 50223
		items.container.insertSubview(b, belowSubview: items.to.view)
		
		items.from.view.isUserInteractionEnabled = false
		//		items.to.view.frame = CGRect(center:items.container.center, size:CGSize(width:items.container.bounds.width * popScale.scale * 0.8, height:items.container.bounds.height * popScale.scale * 0.8))
		items.to.view.transform = CGAffineTransform(scaleX: popScale.scale * 0.8, y: popScale.scale * 0.8)
		UIView.animate(withDuration: transitionDuration(using: context),
		               delay: 0,
		               usingSpringWithDamping: 0.55,
		               initialSpringVelocity: 1 / 0.88,
		               options: [],
		               animations: {
						items.to.view.transform = CGAffineTransform(scaleX: popScale.scale, y: popScale.scale)
		}) { (finish) in
			context.completeTransition(!context.transitionWasCancelled)
			
			items.container.insertSubview(items.from.view, belowSubview: b)
			
			items.to.view.transform = CGAffineTransform.identity
			items.to.view.frame = CGRect(center:items.container.center, size:CGSize(width:items.container.bounds.width * popScale.scale, height:items.container.bounds.height * popScale.scale))
		}
	}
	
	func animationDismissPop(context:UIViewControllerContextTransitioning) {
		guard let items = itemsFromContext(context: context) else { return }
		
		items.from.view.isUserInteractionEnabled = false
		items.container.bringSubview(toFront: items.from.view)
		let originFrame = items.to.view.frame
		UIView.animate(withDuration: transitionDuration(using: context),
		               animations: {
						items.from.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		}) { (finish) in
			items.from.view.removeFromSuperview()
			items.to.view.isUserInteractionEnabled = true
			
			if let v = items.container.viewWithTag(50223) {
				v.removeFromSuperview()
			}
			
			context.completeTransition(!context.transitionWasCancelled)
			
			items.to.view.frame = originFrame
		}
	}
    
    func animationPresentCycle(context:UIViewControllerContextTransitioning) {
        guard let items = itemsFromContext(context: context), let popCycle = popCycle else { return }
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: popCycle).cgPath
        items.to.view.layer.mask = maskLayer
        
        items.from.view.isUserInteractionEnabled = false
        let rate = items.container.frameHeight / popCycle.height
        UIView.animate(withDuration: transitionDuration(using: context),
                       delay: 0,
                       usingSpringWithDamping: 0.55,
                       initialSpringVelocity: 1 / 0.88,
                       options: [],
                       animations: {
                        maskLayer.transform = CATransform3DMakeScale(rate, rate, 1.0)
        }) { (finish) in
            context.completeTransition(!context.transitionWasCancelled)
            
            items.from.view.removeFromSuperview()
            
            items.to.view.layer.mask = nil
        }
    }
    
    func animationDismissCycle(context:UIViewControllerContextTransitioning) {
        guard let items = itemsFromContext(context: context), let popCycle = popCycle else { return }
        
        let rate = items.container.frameHeight / popCycle.height
        
        items.from.view.isUserInteractionEnabled = false
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: popCycle).cgPath
        maskLayer.transform = CATransform3DMakeScale(rate, rate, 1.0)
        items.from.view.layer.mask = maskLayer
        UIView.animate(withDuration: transitionDuration(using: context),
                       animations: {
                        maskLayer.transform = CATransform3DIdentity
        }) { (finish) in
            items.from.view.removeFromSuperview()
            items.to.view.isUserInteractionEnabled = true
            
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
}

extension TransContainer : UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return timeout
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		switch type {
		case .presentLeft:
			animationPresentLeft(context: transitionContext)
		case .dismissLeft:
			animationDismissLeft(context: transitionContext)
		case .presentRight:
			animationPresentRight(context: transitionContext)
		case .dismissRight:
			animationDismissRight(context: transitionContext)
		case .presentTop:
			animationPresentTop(context: transitionContext)
		case .dismissTop:
			animationDismissTop(context: transitionContext)
		case .presentBottom:
			animationPresentBottom(context: transitionContext)
		case .dismissBottom:
			animationDismissBottom(context: transitionContext)
		case .presentScale:
			animationPresentScale(context: transitionContext)
		case .dismissScale:
			animationDismissScale(context: transitionContext)
		case .presentBottomScale:
			animationPresentBottomScale(context: transitionContext)
		case .dismissBottomScale:
			animationDismissBottomScale(context: transitionContext)
		case .presentPop:
			animationPresentPop(context: transitionContext)
		case .dismissPop:
			animationDismissPop(context: transitionContext)
        case .presentCycle:
            animationPresentCycle(context: transitionContext)
        case .dismissCycle:
            animationDismissCycle(context: transitionContext)
		}
	}
}

public class CLTransLeftDelegate : NSObject {
	var duration:TimeInterval
	
	public init(duration d:TimeInterval) {
		duration = d
	}
}

extension CLTransLeftDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentLeft, duration: duration)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissLeft, duration: duration)
	}
}

public class CLTransRightDelegate : NSObject {
	var duration:TimeInterval
	
	public init(duration d:TimeInterval) {
		duration = d
	}
}

extension CLTransRightDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentRight, duration: duration)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissRight, duration: duration)
	}
}

public class CLTransTopDelegate : NSObject {
	var duration:TimeInterval
	
	public init(duration d:TimeInterval) {
		duration = d
	}
}

extension CLTransTopDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentTop, duration: duration)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissTop, duration: duration)
	}
}

public class CLTransBottomDelegate : NSObject {
	var duration:TimeInterval
	
	public init(duration d:TimeInterval) {
		duration = d
	}
}

extension CLTransBottomDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentBottom, duration: duration)
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissBottom, duration: duration)
	}
}

public class CLTransScaleDelegate : NSObject {
	var duration:TimeInterval
	public var view:UIView
	var frame:CGRect
	
	public init(duration d:TimeInterval, view v:UIView, frame f:CGRect) {
		duration = d
		view = v
		frame = f
	}
}

extension CLTransScaleDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentScale, duration: duration, scale: (view, frame))
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissScale, duration: duration, scale: (view, frame))
	}
}

public class CLTransBottomScaleDelegate : NSObject {
	var duration:TimeInterval
	var scale:CGFloat
	var height:CGFloat
	
	public init(duration d:TimeInterval, scale s:CGFloat, height h:CGFloat) {
		duration = d
		scale = s
		height = h
	}
}

extension CLTransBottomScaleDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentBottomScale, duration: duration, scaleBottom: (scale, height))
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissBottomScale, duration: duration, scaleBottom: (scale, height))
	}
}

public class CLTransPopDelegate : NSObject {
	var duration:TimeInterval
	var scale:CGFloat
	var color:UIColor
	
	public init(duration d:TimeInterval, scale s:CGFloat, color c:UIColor) {
		duration = d
		scale = s
		color = c
	}
}

extension CLTransPopDelegate : UIViewControllerTransitioningDelegate {
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.presentPop, duration: duration, popScale: (scale, color))
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return TransContainer(.dismissPop, duration: duration, popScale: (scale, color))
	}
}

public class CLTransCycleDelegate : NSObject {
    var duration:TimeInterval
    var cycle:CGRect
    
    public init(duration d:TimeInterval, cycle c:CGRect) {
        duration = d
        cycle = c
    }
}

extension CLTransCycleDelegate : UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransContainer(.presentCycle, duration: duration, cycle: cycle)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransContainer(.dismissCycle, duration: duration, cycle: cycle)
    }
}
