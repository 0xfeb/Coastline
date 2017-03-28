//
//  PageViewController.swift
//  Coastline
//
//  Created by 王渊鸥 on 2016/10/22.
//  Copyright © 2016年 王渊鸥. All rights reserved.
//

import UIKit

open class CLPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
	var pages:[UIViewController] = []
	open var cycleMode:Bool = false
	open var onSelectPage:(Int) -> () = { _ in }
	
	open func setPages(pages:[UIViewController]) {
		self.dataSource = self
		self.delegate = self
		self.pages = pages
		self.setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
	}
	
	open func gotoPage(index:Int, direction:UIPageViewControllerNavigationDirection = .forward) {
		if pages.count < 2 { return }
		
		if index < pages.count {
			let page = pages[index]
			OperationQueue.main.addOperation { [weak self] in
				self?.setViewControllers([page], direction: direction, animated: false, completion: nil)
			}
		}
	}
	
	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if pages.count < 2 { return nil }
		
		if let index = pages.index(of: viewController) {
			if index == pages.count - 1 {
				return self.cycleMode ? pages.first : nil
			}
			return pages[index+1]
		}
		return nil
	}
	
	open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if pages.count < 2 { return nil }
		
		if let index = pages.index(of: viewController) {
			if index == 0 {
				return self.cycleMode ? pages.last : nil
			}
			return pages[index-1]
		}
		return nil
	}
	
//	open func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//		if let curPage = pendingViewControllers.first {
//			if let index = pages.index(of: curPage) {
//				onSelectPage(index)
//			}
//		}
//	}
	
	public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if let curPage = viewControllers?.first {
			if let index = pages.index(of: curPage) {
				onSelectPage(index)
			}
		}
	}
}

